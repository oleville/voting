class Candidate < ApplicationRecord
	has_many :votes, dependent: :destroy

	belongs_to :election
	belongs_to :position

	def to_s
		name
	end
end
