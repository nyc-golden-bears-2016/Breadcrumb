class FavoritesController < ApplicationController
before_action :current_trail, :redirect, only: [:add, :remove]

  def add
    if !Favorite.find_by(user: current_user, trail: @trail)
      Favorite.create(user: current_user, trail: @trail)
      redirect_to current_user
    else
      redirect_to current_user,
      alert: "Already saved for later"
    end
  end

  def remove
    if Favorite.find_by(user: current_user, trail: @trail)
      Favorite.find_by(user: current_user, trail: @trail).destroy
      render json: params[:id]
    else
      redirect_to current_user,
      alert: "Could not find saved."
    end
  end

private

    def remove_params
      params.require(:saved_params).permit(:id)
    end

    def current_trail
      @trail = Trail.find(params[:id])
    end

    def redirect
     if !current_user
       redirect_to new_user_session_path
     end
    end

end
