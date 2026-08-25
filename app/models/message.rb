class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :user

  validation :content, presence: true, length: { minimum: 2 }
end
