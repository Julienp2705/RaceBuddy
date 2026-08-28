class ProfilesController < ApplicationController
  def show
    @user = current_user
    @pending_invites = current_user.received_invites.pending.includes(:user, target: :race).order(created_at: :desc)
    targets = current_user.targets.includes(:race).order(:id)
    @current_target  = targets.last
    @past_targets    = targets - [@current_target]
  end

  def update
    if current_user.update(profile_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to profile_path, notice: "Avatar mis à jour." }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("avatar_modal_body", partial: "shared/avatar_form", locals: { user: current_user }), status: :unprocessable_entity }
        format.html { render :show, status: :unprocessable_entity }
      end
    end
  end

  private

  def profile_params
    params.require(:user).permit(:avatar)
  end
end

def edit
  @target = Target.find(params[:id])
end
