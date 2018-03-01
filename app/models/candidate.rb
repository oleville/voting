class Candidate < ApplicationRecord
	has_many :votes

	belongs_to :election
	belongs_to :position
end
