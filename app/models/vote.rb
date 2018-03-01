class Vote < ApplicationRecord
  belongs_to :candidate
  belongs_to :user
  belongs_to :election
  belongs_to :position
end
