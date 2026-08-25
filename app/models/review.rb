class Review < ApplicationRecord
  belongs_to :invite

  validates :comment, presence: true, length: { minimum: 10 }
  validates :rating, presence: true, inclusion: { in: [1, 2, 3, 4, 5] }
end
