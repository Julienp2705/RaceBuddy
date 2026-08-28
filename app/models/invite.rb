class Invite < ApplicationRecord
  belongs_to :user
  belongs_to :target
  has_many :reviews, dependent: :destroy
  has_one :chat, dependent: :destroy

  scope :pending, -> { where(status: "pending") }
end
