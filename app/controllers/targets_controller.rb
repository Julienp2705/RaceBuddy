class TargetsController < ApplicationController
  def new
    @race = Race.find(params[:race_id])
    @target = Target.new
  end

  def create
    @race = Race.find(params[:race_id])
    @target = @race.targets.new(target_params)
    @target.user = current_user

    # if @target.save
    # redirect_to @race
    # else
    # puts @target.errors.full_messages
    # render :new, status: :unprocessable_entity
  end

  def destroy
    @target = Target.find(params[:id])
    @target.destroy

    redirect_to profile_path
  end

  def update
    @target = Target.find(params[:id])
    @target.update(target_params)

    redirect_to profile_path
  end

  private

  def target_params
    params.require(:target).permit(:target_hour, :target_minute, :address)
  end
end
