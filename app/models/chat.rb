class Chat < ApplicationRecord
  belongs_to :invite
  has_many :messages

  validates :title, presence: true, length: { minimum: 3, maximum: 20 }
end
