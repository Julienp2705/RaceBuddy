class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :user

  validate :content, presence: true, length: { minimum: 2 }
end
