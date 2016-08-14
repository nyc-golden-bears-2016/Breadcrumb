class FavoritesController < ApplicationController
before_action :current_trail, :redirect, only: [:add, :remove]

  def add
    if !Favorite.find_by(user: current_user, trail: @trail)
      Favorite.create(user: current_user, trail: @trail)
      redirect_to current_user
    else
      redirect_to current_user
      #make error handling
    end
  end

  def remove
    if Favorite.find_by(user: current_user, trail: @trail)
      Favorite.find_by(user: current_user, trail: @trail).destroy
      redirect_to current_user
    else
      redirect_to root_path
      #make error handling
    end
  end

private

    def current_trail
      @trail = Trail.find(params[:id])
    end

    def redirect
     if !current_user
       redirect_to new_user_session_path
     end
    end

  end
