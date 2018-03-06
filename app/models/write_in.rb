class WriteIn < ApplicationRecord
  belongs_to :position
  belongs_to :ballot
  belongs_to :user
end
