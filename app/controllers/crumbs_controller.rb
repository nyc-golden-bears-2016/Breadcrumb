class CrumbsController < ApplicationController
before_action :current_trail, :current_user

#new/edit form is on trail new/edit page

  def update
  end

  def destroy
  end

  private

  def current_trail
    @trail = Trail.find(params[:trail_id])
  end

  def current_user
    @user ||= User.find(session[:user_id])
  end

end
