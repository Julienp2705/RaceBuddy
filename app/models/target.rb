class Target < ApplicationRecord
  belongs_to :race
  belongs_to :user
  has_many :invites

  validates :target_hour, presence: true, inclusion: { in: 0..23 }
  validates :target_minute, presence: true, inclusion: { in: [0, 15, 30, 45] }
end
