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

  def show
    @race = Race.find(params[:id])
    @target = Target.find_by(race: @race, user: current_user)
    @new_target = Target.new
    @buddies = @target.similar if @target
    @buddy_pins = @buddies.map do |buddy|
  {
    lat: buddy.latitude,
    lng: buddy.longitude,
    avatar_url: buddy.user.avatar.attached? ? url_for(buddy.user.avatar) : nil,
    initials: "#{buddy.user.first_name.first}#{buddy.user.last_name.first}"
  }
    end if @target
  end

  private

  def race_params
    params.require(:race).permit(:name, :distance, :url)
  end

end
