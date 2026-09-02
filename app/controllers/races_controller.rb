class RacesController < ApplicationController
  def index
    @race = Race.new
    if params[:query].present?
      @races = Race.search_by_name(params[:query]).limit(10)
    else
      @races = Race.order(created_at: :desc).limit(10)
    end
  end

  def create
    @race = Race.new(race_params)
    if @race.save
      redirect_to race_path(@race)
    else
      @races = Race.all
      redirect_back(
        fallback_location: root_path,
        alert: "Impossible de créer l'objectif."
  )
    end
  end

  def show
    @race = Race.find(params[:id])
    @target = Target.find_by(race: @race, user: current_user)
    @new_target = Target.new
    @buddies = @target.similar if @target
    @buddy_pins = @buddies.map do |buddy|
  {
    lat: buddy.latitude.round(2),
    lng: buddy.longitude.round(2),
    avatar_url: buddy.user.avatar.attached? ? url_for(buddy.user.avatar) : nil,
    initials: "#{buddy.user.first_name.first}#{buddy.user.last_name.first}"
  }
    end if @target
  end

  private

  def race_params
    params.require(:race).permit(:name, :distance, :race_date, :url)
  end

end
