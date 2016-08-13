class CrumbsController < ApplicationController
before_action :current_trail, :current_user

#new/edit form is on trail new/edit page
  def new
    @crumb = @trail.crumbs.new
  end

  def edit
    @crumb = Crumb.find(params[:id])
  end

  def update
  end

  def destroy
  end

  private

  def current_trail
    @trail = Trail.find(params[:trail_id])
  end

  def logged_in?
    !!session[:user_id]
  end

  def current_user
    if logged_in?
      @user ||= User.find(session[:user_id])
    else
      redirect_to new_user_session
    end
  end

end
