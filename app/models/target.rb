class Target < ApplicationRecord
  belongs_to :race
  belongs_to :user
  has_many :invites

  validates :target_hour, presence: true, inclusion: { in: 0..23 }
  validates :target_minute, presence: true, inclusion: { in: [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55] }
  validates :address, presence: true

  geocoded_by :address
  after_validation :geocode, if: ->(record) { record.address.present? && record.address_changed? }
end
