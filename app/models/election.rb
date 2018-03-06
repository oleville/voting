require 'date'

class Election < ApplicationRecord
	has_many :positions, dependent: :destroy
	has_many :ballots, dependent: :destroy

	def self.currently_open
		self.select do |election|
			election.is_open?
		end
	end

	def self.currently_open_to(user)
		return self.all if user && user.is_admin?

		# TODO use AR
		self.select do |election|
			election.is_open?
		end
	end

	def positions_for(user)
		Position.where(group_id: nil, election_id: id) +
			user.positions.where(election_id: id)
	end


	def to_s
		name
	end

	def is_open?
		now = DateTime.now
		(start_time <= now) && (now < end_time)
	end
end
