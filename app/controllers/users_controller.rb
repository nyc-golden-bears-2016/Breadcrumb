class UsersController < ApplicationController
before_action :redirect

  def show
    @trails = current_user.nearby_trails.published
    @page = User.find(params[:id])
  end

  def set_user_coords
    byebug
    current_user.set_coords(user_coord_params[:lat].to_f, user_coord_params[:lng].to_f)
  end

  private

  def redirect
   if !current_user
     redirect_to new_user_session_path
   end
  end

  def user_coord_params
    params.require(:user_position).permit(:lat, :lng, :sound)
  end

end
