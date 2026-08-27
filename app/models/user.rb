class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :avatar
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :invites
  has_many :targets
  has_many :messages
  has_many :received_invites, through: :targets, source: :invites

  # validates :first_name, presence: true, length: { minimum: 3, maximum: 20 }
  # validates :last_name, presence: true, length: { minimum: 3, maximum: 20 }

  geocoded_by :address
  after_validation :geocode, if: ->(record) { record.address.present? && record.address_changed? }
end
