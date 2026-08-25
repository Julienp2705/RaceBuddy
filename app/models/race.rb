class Race < ApplicationRecord
  has_one_attached :image
  has_many :targets
end
