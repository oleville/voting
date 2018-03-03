class Group < ApplicationRecord

	has_many :memberships, dependent: :destroy
	has_many :users, through: :memberships
	has_many :positions, dependent: :destroy

	def to_s
		name
	end

end
