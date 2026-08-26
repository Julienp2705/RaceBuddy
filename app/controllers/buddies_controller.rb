class BuddiesController < ApplicationController
  def show
    @buddie = User.find(params[:id])
  end
end
