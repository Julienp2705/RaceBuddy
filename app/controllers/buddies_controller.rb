class BuddiesController < ApplicationController
  def show
    @buddie = User.find(params[:id])
    targets = @buddie.targets.includes(:race).order(:id)

    @current_target = targets.last
    @past_targets   = targets - [@current_target]
  end
end
