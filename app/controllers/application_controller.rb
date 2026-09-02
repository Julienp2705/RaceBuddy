class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?

  def update
    if current_user.update(user_params)
      render json: { description: current_user.description }
    else
      render json: { errors: current_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:description)
  end
end
