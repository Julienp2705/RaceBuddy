class Race < ApplicationRecord
  has_one_attached :image
  has_many :targets

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :distance, presence: true, numericality: { greater_than: 0 }
  validates :url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }

  include PgSearch::Model

  pg_search_scope :search_by_name,
    against: [:name],
    using: {
      tsearch: { prefix: true }
    }
end
