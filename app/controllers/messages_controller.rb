class MessagesController < ApplicationController
  def create
    @chat = Chat.find(params[:chat_id])

    unless chat_users.include?(current_user)
      redirect_to root_path, alert: "Vous n'avez pas accès à cette conversation."
      return
    end

    @message = @chat.messages.new(message_params)
    @message.user = current_user

    if @message.save
      redirect_to chat_path(@chat)
    else
      @messages = @chat.messages.includes(:user).order(created_at: :asc)
      @other_user = @chat.other_user(current_user)
      render "chats/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def chat_users
    [
      @chat.invite.user,
      @chat.invite.target.user
    ]
  end
end
