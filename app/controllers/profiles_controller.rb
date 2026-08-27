class ProfilesController < ApplicationController
  def show
    @user = current_user
    @target = current_user.targets.last
  end
end

# def edit
# @target = Target.find(params[:id])
# end
