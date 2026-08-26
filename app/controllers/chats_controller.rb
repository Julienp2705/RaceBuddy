class ChatsController < ApplicationController
  def show
    @chat = Chat.find(params[:id])

    unless chat_users.include?(current_user)
      redirect_to root_path, alert: "Vous n'avez pas accès à cette conversation."
      return
    end

    @messages = @chat.messages.includes(:user).order(created_at: :asc)
    @message = Message.new

    @other_user = if @chat.invite.user == current_user
                  @chat.invite.target.user
                else
                  @chat.invite.user
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
