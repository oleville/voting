class Ballot < ApplicationRecord
	belongs_to :user
	belongs_to :election

	has_many :votes, dependent: :destroy

	accepts_nested_attributes_for :votes
end
