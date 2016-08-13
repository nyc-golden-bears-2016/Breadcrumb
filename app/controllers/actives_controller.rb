class ActivesController < ApplicationController
before_action :current_trail, except: [:crumb]
before_action :redirect

  def join
    # if @trail.private
    #    render json: @errors
    # else
    #   redirect "/active/#{@trail.id}"
    # end
    Experience.create(user: @user, trail: @trail)
  end

  def leave

  end

  def show

    #can we call the last crumb they hit and mark it as a save point?
    # made a new column in the experience model to hold that info
  end

  def crumb
    #this route is nested, finding the trail is different
    @trail = Trail.find(params[:active_id])
    @crumb = Crumb.find(params[:id])
    if @trail.sequential
      Experience.update_attribute(last_crumb_reached: @crumb.order_number)
    end
  end

  def update
  #update number of available bullets
  end

private

  def current_trail
    @trail ||= Trail.find(params[:id])
  end

  def redirect
   if !current_user
     redirect_to new_user_session_path, notice: 'You are not logged in.'
   end
  end

  # def location_params
  #   params.require(:location).permit(:latitude, :longitude)
  # end

end
