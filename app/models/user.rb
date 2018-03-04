class User < ApplicationRecord
	# Not sure if this should be has_many or has_one... we'll see.
	# belongs_to :election

	has_many :memberships, dependent: :destroy
	has_many :groups, through: :memberships
	has_many :positions, through: :groups
	has_many :ballots, dependent: :destroy
	has_many :votes, through: :ballots

	validates :email, presence: true
	validates :email, uniqueness: true

	validates :name, presence: true

	def self.from_omniauth(auth)
		existing_user = where(provider: auth.provider, uid: auth.uid).or(where(email: auth.info.email)).first

		raise "What" if !existing_user

		existing_user.tap do |user|
			user.provider = auth.provider
			user.uid = auth.uid
			user.name = auth.info.name
			user.email = auth.info.email
			user.auth_token = auth.credentials.token
			user.auth_token_expiration = Time.at(auth.credentials.expires_at)
			user.save!
		end
	end

	def to_s
		name
	end

	def is_admin?
		admin
	end
end
