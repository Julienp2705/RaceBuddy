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

  def users
    [invite.user, invite.target.user]
  end
  def read_column_for(user)
    invite.user == user ? :inviter_read_at : :invitee_read_at
  end

  def unread_count_for(user)
    read_at = self[read_column_for(user)]
    scope = messages.where.not(user: user)
    read_at ? scope.where("created_at > ?", read_at).count : scope.count
  end

  def unread_for?(user)
    unread_count_for(user) > 0
  end

  def mark_read_for!(user)
    update_column(read_column_for(user), Time.current)
  end
end
