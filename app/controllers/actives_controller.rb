class ActivesController < ApplicationController
before_action :log_in
before_action :current_trail, except: [:join, :joined, :crumb, :answered]
before_action :correct_password, only: [:show, :crumb, :update, :destroy]
before_action :current_active, only: [:show, :update, :destroy]
before_action :correct_password, only: [:show, :update]
before_action :which_trail, only: [:joined, :join]

  def join
    if !Active.find_by(user: current_user, trail: @newtrail)
      if @newtrail.priv == false
        @active = Active.create(user: current_user, trail: @newtrail)
        redirect_to "/actives/#{@active.id}"
      else
        @active = Active.new
      end
    else
      redirect_to "/actives/#{Active.find_by(user: current_user, trail: @newtrail).id}"
    end
  end

  def joined
    entered = priv_trail_params[:entered_password]
    if entered == @newtrail.password
      @active = Active.create(user: current_user, trail: @newtrail, entered_password: entered)
      redirect_to "/actives/#{@active.id}"
    else
      redirect_to current_user
      #make error handling
    end
  end

  def leave

  end

  def show
    @active ||= Active.create(user: current_user, trail: @trail)
    @crumbs = @active.crumbs_available

    if @active.trail.sequential && (@trail.crumbs.length < @active.last_crumb_reached) && (@trail.crumbs.length > 1)
      @message = "Ya finished, bro"
    end
  end

  def finished
  end

  def crumb
    #this route is nested, finding the trail is different
    @active = Active.find(params[:active_id])
    @trail = @active.trail
    @crumb = Crumb.find(params[:id])
    if @trail.sequential && (@crumb.requires_answer == false)
      @active.update_attribute(:last_crumb_reached, @crumb.order_number += 1)
    end
  end

  def answered
    @active = Active.find(params[:active_id])
    @crumb = Crumb.find(params[:id])
    entered = locked_crumb_params[:entered_answer]
    if entered == @crumb.answer
      @active.update_attribute(:last_crumb_reached, @crumb.order_number += 1)
      redirect_to "/actives/#{@active.id}"
    else
      redirect_to "/actives/#{@active.id}/crumbs/#{@crumb.id}"
      #make error handling
    end
  end

  def mapdetails
    sorted_crumbs = current_trail.crumbs.sort{|x,y| x.created_at <=> x.created_at}
    render :json => {crumbs: sorted_crumbs, 
                     zoom: calculate_zoom, 
                     initialLat: current_trail.latitude,
                     initialLng: current_trail.longitude,
                     currentCrumb: current_active.last_crumb_reached}
                    
  end

  def update
  #update number of available bullets
    unless @active.last_crumb_reached == @active.trail.crumbs.length
      @active.last_crumb_reached +=1
    end
  end

  def destroy
    @active.destroy
    redirect_to current_user
  end

private

  def current_trail
    @trail ||= Active.find(params[:id]).trail
  end

  def which_trail
    @newtrail = Trail.find(params[:id])
  end

  def current_active
    @active ||= Active.find(params[:id])
  end

  def log_in
   if !current_user
     redirect_to new_user_session_path
   end
  end

  def locked_crumb_params
    params.permit(:entered_answer)
  end

  def priv_trail_params
    params.require(:active).permit(:entered_password)
  end

  def correct_password
    if @trail.priv
      if @trail.password == @active.entered_password
        true
      else
        redirect_to new_user_session_path
      end
    else
      true
    end
  end


  def active_redirect
    if Active.find(params[:active_id]).last_crumb_reached >= Crumb.find(params[:id])
        true
    elsif trail_creator
      true
    else
      redirect_to "/actives/#{params[:active_id]}/join"
     end
  end

  def calculate_zoom
    latitudes = current_trail.crumbs.map {|crumb| crumb.latitude}
    longitudes = current_trail.crumbs.map {|crumb| crumb.longitude}
    lat_distance = latitudes.sort[-1] - latitudes.sort[0]
    lng_distance = longitudes.sort[-1] - longitudes.sort[0]
    if (lng_distance / 3) >= (lat_distance / 2) 
      biggest_distance = lng_distance
    else
      biggest_distance = lat_distance
    end
    if biggest_distance < 0.02
      return 18
    elsif biggest_distance < 0.04
      return 16
    elsif biggest_distance < 0.06  
      return 14
    elsif biggest_distance < 0.08  
      return 12
    elsif biggest_distance < 2 
      return 10
    elsif biggest_distance < 5
      return 8
    else  
      return 4
    end
  end

end
