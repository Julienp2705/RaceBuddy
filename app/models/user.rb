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
  # les notes que cet utilisateur a données
  has_many :given_ratings, class_name: "BuddyRating",
           foreign_key: :user_id, dependent: :destroy

  # les notes que cet utilisateur a reçues
  has_many :received_ratings, class_name: "BuddyRating",
           foreign_key: :buddy_id, dependent: :destroy

  has_many :rated_buddies, through: :given_ratings, source: :buddy
  has_many :raters, through: :received_ratings, source: :user

  validates :first_name, presence: true, length: { minimum: 3, maximum: 20 }, allow_blank: true
  validates :last_name, presence: true, length: { minimum: 3, maximum: 20 }, allow_blank: true

  DEFAULT_AVATAR_URL = "https://res.cloudinary.com/en57d7v3/image/upload/v1787911056/default_avatar.png".freeze
  ALLOWED_AVATAR_TYPES = %w[image/jpeg image/png image/webp].freeze
  MAX_AVATAR_SIZE = 5.megabytes

  has_one_attached :avatar
  has_many :races, through: :targets

  validate :avatar_valid, if: -> { avatar.attached? && avatar.blob.present? }

  def avatar_url
    avatar.attached? ? Rails.application.routes.url_helpers.rails_blob_path(avatar, only_path: true) : DEFAULT_AVATAR_URL
  end

  def initials
    first = first_name.present? ? first_name.first : "?"
    last  = last_name.present? ? last_name.first : ""
    "#{first}#{last}".upcase
  end
  def votes_count
    received_ratings.count
  end

  def thumbs_up_percentage
    return 0 if votes_count.zero?

    (received_ratings.where(rating: 1).count * 100.0 / votes_count).round
  end

  private

  def avatar_valid
    unless ALLOWED_AVATAR_TYPES.include?(avatar.blob.content_type)
      errors.add(:avatar, "doit être une image JPEG, PNG ou WebP")
    end
    if avatar.blob.byte_size > MAX_AVATAR_SIZE
      errors.add(:avatar, "doit faire moins de 5 Mo")
    end
  end
end
