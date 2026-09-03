class MessagesController < ApplicationController
  before_action :set_chat
  before_action :set_message, only: %i[update destroy]
  before_action :authorize_message!, only: %i[update destroy]

  def create
    unless chat_users.include?(current_user)
      redirect_to root_path, alert: "Vous n'avez pas accès à cette conversation."
      return
    end

    @message = @chat.messages.new(message_params)
    @message.user = current_user

    if @message.save
      @messages = @chat.messages.includes(:user).order(created_at: :asc)
      @other_user = @chat.other_user(current_user)

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to chat_path(@chat) }
      end
    else
      @messages = @chat.messages.includes(:user).order(created_at: :asc)
      @other_user = @chat.other_user(current_user)

      render "chats/show", status: :unprocessable_entity
    end
  end

  def update
    if @message.update(message_params)
      redirect_to chat_path(@chat), notice: "Message modifié."
    else
      @messages = @chat.messages.includes(:user).order(created_at: :asc)
      @other_user = @chat.other_user(current_user)
      render "chats/show", status: :unprocessable_entity
    end
  end

  def destroy
    @message.destroy
    redirect_to chat_path(@chat), notice: "Message supprimé."
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def set_chat
    @chat = Chat.find(params[:chat_id])
  end

  def set_message
    @message = @chat.messages.find(params[:id])
  end

  def chat_users
    [
      @chat.invite.user,
      @chat.invite.target.user
    ]
  end

  def authorize_message!
    return if @message.user == current_user

    redirect_to chat_path(@chat),
                alert: "Vous ne pouvez pas modifier ce message."
  end
end
