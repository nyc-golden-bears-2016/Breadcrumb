class UsersController < ApplicationController
before_action :redirect


  def show
    #unpublished trails - link to edit
    #published trails - private have password next to it
    #walked trails
    #perhaps tags that are interests?
    @trails = Trail.where(published: true).page params[:page]
    @page = User.find(params[:id])

  end

  def set_user_coords
    current_user.set_coords(user_coord_params[:lat].to_f, user_coord_params[:lng].to_f)
  end

  private


  def redirect
   if !current_user
     redirect_to new_user_session_path
   end
  end
  def user_coord_params
    # byebug
    params.require(:user_position).permit(:lat, :lng)
  end
end
