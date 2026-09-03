class ChatsController < ApplicationController
  def show
    @chat = Chat.find(params[:id])
    @chat.mark_read_for!(current_user)

    unless chat_users.include?(current_user)
      redirect_to root_path, alert: "Vous n'avez pas accès à cette conversation."
      return
    end

    @messages = @chat.messages.includes(:user).order(created_at: :asc)
    @message = Message.new

    @other_user = @chat.other_user(current_user)
  end

  def index
    @chats = Chat.includes(invite: { target: :user }).select do |chat|
      chat.invite.user == current_user ||
        chat.invite.target.user == current_user
    end
  end

  def destroy
    @chat = Chat.find(params[:id])
    unless chat_users.include?(current_user)
      redirect_to chats_path, alert: "Vous n'avez pas accès à cette conversation."
      return
    end
    if @chat.destroy
      redirect_to chats_path, notice: "Conversation supprimée."
    else
      redirect_to chats_path, alert: "Impossible de supprimer la conversation."
    end
  end

  private

  def chat_users
    [
      @chat.invite.user,
      @chat.invite.target.user
    ]
  end
end
