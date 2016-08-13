class ActivesController < ApplicationController
before_action :current_trail, except: [:crumb]
before_action :log_in

  def join
    @active = Active.new
    if @trail.priv == false
      redirect_to "/actives/#{@trail.id}"
    end
  end

  def joined
    if priv_trail_params

    end
  end

  def leave

  end

  def show
    @active ||= Active.create(user: current_user, trail: @trail)
    #can we call the last crumb they hit and mark it as a save point?
    # made a new column in the experience model to hold that info
  end

  def crumb
    #this route is nested, finding the trail is different
    @trail = Trail.find(params[:active_id])
    @crumb = Crumb.find(params[:id])
    if @trail.sequential
      Active.update_attribute(last_crumb_reached: @crumb.order_number)
    end
  end

  def update
  #update number of available bullets
  end

private

  def current_trail
    @trail ||= Trail.find(params[:id])
  end

  def log_in
   if !current_user
     redirect_to new_user_session_path
   end
  end

  def priv_trail_params
    params.require(:active).permit(:entered_password)
  end


end
