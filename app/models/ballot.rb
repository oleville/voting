class Ballot < ApplicationRecord
	belongs_to :user
	belongs_to :election

	has_many :votes, dependent: :destroy
	has_many :write_ins, dependent: :destroy

	accepts_nested_attributes_for :votes
	accepts_nested_attributes_for :write_ins
end
