class TargetsController < ApplicationController
  def create
    @race = Race.find(params[:race_id])
    @target = @race.targets.new(target_params)
    @target.user = current_user

    if @target.save
      redirect_to @race
    else
      @new_target = @target
      @target = nil
      render "races/show", status: :unprocessable_entity
    end
  end

  def destroy
    @target = Target.find(params[:id])
    @target.destroy

    redirect_to profile_path
  end

  def edit
    @target = Target.find(params[:id])
  end

  def update
    @target = Target.find(params[:id])
    if @target.update(target_params)
      redirect_to profile_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def target_params
    params.require(:target).permit(:target_hour, :target_minute, :address)
  end
end
