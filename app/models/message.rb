class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :user

  validates :content, presence: true, length: { minimum: 2 }

  after_create_commit :notify_recipient

  private

  def notify_recipient
    recipient = chat.other_user(user)

    broadcast_update_to recipient,
      target: "nav-unread-badge",
      partial: "shared/unread_badge",
      locals: { user: recipient }

    broadcast_replace_to recipient,
      target: "chat-card-#{chat.id}",
      partial: "chats/chat_card",
      locals: { chat: chat, current_user: recipient }

    chat.users.each do |user|
      broadcast_replace_to chat,
      target: "chat-messages",
      partial: "messages/messages",
      locals: {
        messages: chat.messages.includes(:user).order(created_at: :asc),
        other_user: chat.other_user(recipient),
        chat: chat,
        message: nil,
        viewer: recipient
      }
    end
  end
end
