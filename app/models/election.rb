require 'date'

class Election < ApplicationRecord
	has_many :positions, dependent: :destroy

	def self.currently_open_to(user)
		return self.all if user && user.is_admin?

		# TODO use AR
		self.select do |election|
			election.is_open?
		end
	end

	def to_s
		name
	end

	def is_open?
		now = DateTime.now
		start_time <= now && now < end_time
	end
end
