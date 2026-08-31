class BuddyRating < ApplicationRecord
  belongs_to :user
  belongs_to :buddy, class_name: "User"

  validates :rating, inclusion: { in: [-1, 1]  }
  validates :user_id, uniqueness: { scope: :buddy_id }
  validate :cannot_rate_self

  private

  def cannot_rate_self
    errors.add(:buddy, "ne peut pas être soi-même") if user_id == buddy_id
  end
end
