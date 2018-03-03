class Vote < ApplicationRecord
  belongs_to :candidate
  belongs_to :user
	belongs_to :ballot
  belongs_to :position
end
