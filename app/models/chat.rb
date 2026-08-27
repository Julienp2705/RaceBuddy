class Chat < ApplicationRecord
  belongs_to :invite
  has_many :messages, dependent: :destroy

  def other_user(current_user)
    if invite.user == current_user
      invite.target.user
    else
      invite.user
    end
  end
  
end
