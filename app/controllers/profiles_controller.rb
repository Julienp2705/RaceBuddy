class ProfilesController < ApplicationController
  def show
    @user = current_user
    @pending_invites = current_user.received_invites.pending.includes(:user, target: :race).order(created_at: :desc)
    targets = current_user.targets.includes(:race).order(:id)
    @current_target  = targets.last
    @past_targets    = targets - [@current_target]
  end
end
