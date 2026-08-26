class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :user

  validates :content, presence: true, length: { minimum: 2 }
end
