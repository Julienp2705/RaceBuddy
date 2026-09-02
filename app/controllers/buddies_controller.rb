class BuddiesController < ApplicationController
  def show
    @buddie = User.find(params[:id])
    targets = @buddie.targets.joins(:race).includes(:race)
    @upcoming_targets = targets.merge(Race.upcoming)
    @past_targets     = targets.merge(Race.past)

    @invite = Invite.where(user: current_user, target: @buddie.targets)
                .or(Invite.where(user: @buddie, target: current_user.targets)).first

    @buddy_rating = BuddyRating.find_by(
      user: current_user,
      buddy: @buddie
    )
    @target = @buddie.targets.joins(:race).merge(Race.upcoming).first
  end
end
