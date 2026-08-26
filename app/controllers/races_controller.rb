class RacesController < ApplicationController
  def index
    @races = Race.all
  end

  def show
    @race = Race.find(params[:id])
    @target = Target.find_by(race: @race, user: current_user)
  end
end
