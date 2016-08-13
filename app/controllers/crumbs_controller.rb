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

  def trail_creator
    if !(current_user == @trail.creator)
      redirect_to new_user_session_url
    end
  end


end
