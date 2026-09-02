class Invite < ApplicationRecord
  belongs_to :user
  belongs_to :target

  has_one :chat, dependent: :destroy

  scope :pending, -> { where(status: "pending") }
  validate :no_reverse_invite, on: :create

  def accept!
    update!(status: "accepted")
    self.chat || Chat.create!(invite: self, title: target.race.name)
  end
  
  private

  def no_reverse_invite
    return if user.nil? || target.nil?

    exists = Invite.where(user: target.user, target: user.targets).exists? ||
      Invite.where(user: user, target: target.user.targets).exists?

    errors.add(:base, "Une invitation existe déjà entre vous.") if exists
  end
end
