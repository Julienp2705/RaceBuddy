class InvitesController < ApplicationController
  def create
    @target = Target.find(params[:target_id])

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

    @invite.update!(status: "accepted")

    @chat = @invite.chat || Chat.create!(
      invite: @invite,
      title: @invite.target.race.name
    )

    redirect_to chat_path(@chat)
  end

  def destroy
    @invite = current_user.received_invites.find(params[:id])
    @invite.destroy

    redirect_to profile_path, notice: "Invitation refusée.", status: :see_other
  rescue ActiveRecord::RecordNotFound
    redirect_to profile_path, alert: "Invitation introuvable.", status: :see_other
  end
end
