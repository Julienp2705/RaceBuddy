class Target < ApplicationRecord
  belongs_to :race
  belongs_to :user
  has_many :invites, dependent: :destroy

  validates :target_hour, presence: true, inclusion: { in: 0..23 }
  validates :target_minute, presence: true, inclusion: { in: [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55] }
  validates :address, presence: true
  validates :address, format: { with: /\A(?:[0-9]{5}|[\p{L}\p{M}\s\-']+)\z/ }, allow_blank: true

  geocoded_by :address
  after_validation :geocode, if: ->(record) { record.address.present? && record.address_changed? }

  def similar(minutes: 15, radius_km: 5)
    total_min = (target_hour * 60) + target_minute

    Target.where(race_id: race_id)
          .near([latitude, longitude], radius_km)
          .where.not(id: id)
          .where("(target_hour * 60 + target_minute) BETWEEN ? AND ?",
                total_min - minutes, total_min + minutes)
  end
end
