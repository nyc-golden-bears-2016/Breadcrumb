class FavoritesController < ApplicationController
before_action :current_trail, :redirect

  def add
    #just get links to create/destroy favorites associations
    if !Favorite.find_by(user: current_user, trail: @trail)
      Favorite.create(user: @user, trail: @trail)
    else
      render '_error'
    end
  end

  def remove
    if Favorite.find_by(user: current_user, trail: @trail)
      Favorite.find_by(user: current_user, trail: @trail).destroy
    else
      render '_error'
    end
  end

private

    def current_trail
      @trail = Trail.find(params[:id])
    end

    def redirect
     if !current_user
       redirect_to new_user_session_path, notice: 'You are not logged in.'
     end
    end

  end
