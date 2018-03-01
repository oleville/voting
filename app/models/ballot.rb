class Ballot < ApplicationRecord
  belongs_to :user
	belongs_to :election
	has_many :votes
end
