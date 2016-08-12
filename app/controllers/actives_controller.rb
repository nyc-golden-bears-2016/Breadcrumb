class ActivesController < ApplicationController
before_action :current_trail, except: [:crumb]
before_action :current_user

  def join
    # if @trail.private
    #    render json: @errors
    # else
    #   redirect "/active/#{@trail.id}"
    # end
    Experience.create(user: @user, trail: @trail)
  end

  def leave
    crumb = Experience.last_crumb_reached
    #can we call the last crumb they hit and mark it as a save point?
    # made a new column in the experience model to hold that info
  end

  def show
  end

  def crumb
    #this route is nested, finding the trail is different
    @trail = Trail.find(params[:active_id])
    @crumb = Crumb.find(params[:id])
    if @trail.sequential
      Experience.update(last_crumb_reached: @crumb.order_number)
    end
  end

  def update
  #update number of available bullets
  end

private

  def current_trail
    @trail = Trail.find(params[:id])
  end

  def current_user
    @user ||= User.find(session[:user_id])
  end

  # def location_params
  #   params.require(:location).permit(:latitude, :longitude)
  # end

end
