class Position < ApplicationRecord
	belongs_to :election
	belongs_to :group, optional: true

	has_many :candidates, dependent: :destroy
	has_many :votes, dependent: :destroy
	has_many :ballots, through: :votes

	validates :group_id, presence: true, allow_nil: true

	def to_s
		name
	end
end
