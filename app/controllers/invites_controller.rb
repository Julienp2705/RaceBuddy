class InvitesController < ApplicationController
  def create
    @target = Target.find(params[:target_id])

    reverse = Invite.where(user: @target.user, target: current_user.targets).first

    if reverse
      chat = reverse.accept!
      redirect_to chat_path(chat), notice: "Vous êtes maintenant buddies !"
      return
    end

    @invite = Invite.new(
      user: current_user,
      target: @target,
      status: "pending"
    )

    if @invite.save
      redirect_to @target.race, notice: "Invitation envoyée !"
    else
      redirect_to @target.race, alert: "Impossible d'envoyer l'invitation."
    end
  end

  def accept
    @invite = Invite.find(params[:id])
    chat = @invite.accept!

    redirect_to chat_path(chat)
  end

  def destroy
    @invite = current_user.received_invites.find(params[:id])
    @invite.destroy

    redirect_to profile_path, notice: "Invitation refusée.", status: :see_other
  rescue ActiveRecord::RecordNotFound
    redirect_to profile_path, alert: "Invitation introuvable.", status: :see_other
  end


end
