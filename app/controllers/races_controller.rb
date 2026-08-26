class RacesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    if params[:query].present?
      @races = Race.search_by_name(params[:query]).limit(10)
    else
      @races = Race.order(created_at: :desc).limit(10)
    end
    @race = Race.new
  end

  def create
    @race = Race.new(race_params)
    if @race.save
      redirect_to race_path(@race)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def race_params
    params.require(:race).permit(:name, :distance, :url)
  end

  def show
    @race = Race.find(params[:id])
    @target = Target.find_by(race: @race, user: current_user)
  end
end
