class Position < ApplicationRecord
	belongs_to :election
	belongs_to :group, optional: true

	has_many :candidates, dependent: :destroy

	validates :group_id, presence: true, allow_nil: true

	def to_s
		name
	end
end
