class FavoritesController < ApplicationController
before_action :current_trail, :current_user

  def add
    #just get links to create/destroy favorites associations
    if !Favorite.find_by(user: @user, trail: @trail)
      Favorite.create(user: @user, trail: @trail)
    else
      render '_error'
    end
  end

  def remove
    if Favorite.find_by(user: @user, trail: @trail)
      Favorite.find_by(user: @user, trail: @trail).destroy
    else
      render '_error'
    end
  end

private

    def current_trail
      @trail = Trail.find(params[:id])
    end

    def current_user
      @user ||= User.find(session[:user_id])
    end

  end
