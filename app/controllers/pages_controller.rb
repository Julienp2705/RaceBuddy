class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
    if params[:query].present?
      @races = Race.search_by_name(params[:query]).limit(10)
    else
      @races = Race.order(created_at: :desc).limit(10)
    end
    @race = Race.new
  end
end
