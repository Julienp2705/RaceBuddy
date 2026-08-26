class Chat < ApplicationRecord
  belongs_to :invite
  has_many :messages, dependent: :destroy
end
