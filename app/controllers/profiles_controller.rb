class ProfilesController < ApplicationController
  def show
    @user = current_user
    @pending_invites = current_user.received_invites.pending.includes(:user, target: :race).order(created_at: :desc)
    targets = @user.targets.joins(:race).includes(:race)
    @upcoming_targets = targets.merge(Race.upcoming)
    @past_targets     = targets.merge(Race.past)
  end

  def update
    if params[:remove_avatar].present?
      current_user.avatar.purge
      redirect_to profile_path, notice: "Photo supprimée."
      return
    end

    if current_user.update(profile_params)
      redirect_to profile_path, notice: "Avatar mis à jour."
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "avatar_modal_body",
            partial: "shared/avatar_form",
            locals: { user: current_user }
          ), status: :unprocessable_entity
        end
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
