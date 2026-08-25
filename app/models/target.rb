class Target < ApplicationRecord
  belongs_to :race
  belongs_to :user
  has_many :invites
end
