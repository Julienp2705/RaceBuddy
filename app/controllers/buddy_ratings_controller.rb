class BuddyRatingsController < ApplicationController
  def create
    @buddie = User.find(params[:user_id])

    invite = Invite.where(user: current_user, target: @buddie.targets)
               .or(Invite.where(user: @buddie, target: current_user.targets)).first

    unless invite
      redirect_to buddy_path(@buddie), alert: "Tu ne peux pas noter ce buddy."
      return
    end

    rating = BuddyRating.new(
      user: current_user,
      buddy: @buddie,
      rating: params[:rating]
    )

    if rating.save
      redirect_to buddy_path(@buddie), notice: "Merci pour ton retour !"
    else
      redirect_to buddy_path(@buddie), alert: "Impossible d'enregistrer ton avis."
    end
  end
end
