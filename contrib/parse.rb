require 'csv'
require 'pp'

$data = open(ARGV.shift, 'rb') do |io|
	io.read
end

$csv = CSV.parse($data)

$csv = $csv[1..-1]

class Entry
	attr_reader :username
	attr_reader :name
	attr_reader :year
	attr_reader :groups

	def initialize(username, name, year, groups)
		@username = username
		@name = name
		@year = year.to_i
		@groups = groups && groups.split
	end

	def email
		"#{@username.downcase}@stolaf.edu"
	end

	def right_name
		name_tokenize.join(' ')
	end

	protected

	def name_tokenize
		tokens = @name.split(', ')

		if tokens.count > 1
			tokens = tokens.reverse
		end

		tokens
	end
end

$entries = $csv.map do |line|
	Entry.new(line[0], line[1], line[2], line[3])
end

groups_to_create = $entries.map do |entry|
	entry.groups
end.flatten.uniq.select do |group|
	!!group
end

puts "Creating the following groups: "

groups_to_create.each do |group_name|
	unless group = Group.where(name: group_name).first
		puts "Group #{group_name} does not exist... creating."
		Group.create(name: group_name)
	else
		puts "Already have group for #{group_name}"
	end
end

users_to_create = $entries.map do |entry|
	{ name: entry.right_name, email: entry.email }
end

memberships_to_create = $entries.select do |entry|
	entry.groups != nil
end.map do |entry|
	{ user: { name: entry.right_name, email: entry.email }, groups: entry.groups.flatten}
end

puts "Creating #{users_to_create.count} users..."

users_to_create.each do |user|
	unless u = User.where(name: user[:name]).where(email: user[:email]).first
		puts "Creating an account for #{user[:email]}..."
		User.create(name: user[:name], email: user[:email])
	else
		# puts "Already have user for #{user[:email]}"
	end
end

puts "Creating #{memberships_to_create.count} memberships..."

memberships_to_create.each do |n|
	u = User.where(name: n[:user][:name]).where(email: n[:user][:email]).first

	n[:groups].each do |ngroup|
		g = Group.where(name: ngroup).first

		unless u && g
			$stderr.puts "#{u.inspect}, #{g.inspect}, something's wrong"
		end

		unless m = Membership.where(user_id: u.id, group_id: g.id).first
			puts "Putting user #{u.email} in group #{g.name}"

			Membership.create(user: u, group: g)
		end
	end
end
