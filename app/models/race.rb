class Race < ApplicationRecord
  has_one_attached :image
  has_many :targets

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :distance, presence: true, numericality: { greater_than: 0 }
  validates :url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }
  validates :race_date, presence: true

  include PgSearch::Model

  pg_search_scope :search_by_name,
    against: [:name],
    using: {
      tsearch: { prefix: true }
    }

  scope :upcoming, -> { where(race_date: Date.current..).order(:race_date) }
  scope :past,     -> { where(race_date: ...Date.current).order(race_date: :desc) }
end
