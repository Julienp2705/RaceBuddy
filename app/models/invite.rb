class Invite < ApplicationRecord
  belongs_to :user
  belongs_to :target
  has_many :reviews
  has_many :chats
end
