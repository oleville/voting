class User < ApplicationRecord
	# Not sure if this should be has_many or has_one... we'll see.
	# belongs_to :election

	has_many :groups, through: :memberships
	has_many :memberships
	has_many :votes

	validates :email, presence: true
	validates :email, uniqueness: true

	validates :name, presence: true

	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).or(where(email: auth.info.email)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
			user.name = auth.info.name
			user.email = auth.info.email
      user.auth_token = auth.credentials.token
      user.auth_token_expiration = Time.at(auth.credentials.expires_at)
      user.save!
    end
	end

	def is_admin?
		admin
	end
end
