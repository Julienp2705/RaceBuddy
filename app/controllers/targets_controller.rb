class TargetsController < ApplicationController
  def new
    @race = Race.find(params[:race_id])
    @target = Target.new
  end

  def create
    @race = Race.find(params[:race_id])
    @target = @race.targets.new(target_params)
    @target.user = current_user

    if @target.save
      #redirect_to @race
      redirect_to root_path
    else
      puts @target.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  private
  def target_params
    params.require(:target).permit(:target_hour, :target_minute)
  end
end
