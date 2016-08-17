class ActivesController < ApplicationController
before_action :log_in
before_action :new_trail, only: [:joined, :join]
before_action :current_active, only: [:show, :update, :destroy, :reached]
before_action :current_trail, :correct_password, :published?, only: [:show, :update, :reached]

  def join
    if !Active.find_by(user: current_user, trail: @newtrail)
      if @newtrail.priv == false
        @active = Active.create(user: current_user, trail: @newtrail)
        @active.copy_crumbs
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
      @active.copy_crumbs
      redirect_to "/actives/#{@active.id}/"
    else
      redirect_to request.referer,
      alert: "Incorrect password."
    end
  end

  def show
    @active ||= Active.create(user: current_user, trail: @trail)
    @crumbs = @active.crumbs_available
  end

  def reached
      @active.last_crumb_reached = params[:crumb][:id].to_i
      @active.save
      render json: {route: "/actives/#{@active.id}/active_crumbs/"}
  end

  def destroy
    @active.destroy
    render json: params[:id]
  end

  def mapdetails
    sorted_crumbs = current_active.active_crumbs.sort{|x,y| x.order_number <=> x.order_number}
    render :json => {crumbs: sorted_crumbs,
                     initialLat: current_user.latitude,
                     initialLng: current_user.longitude,
                     currentCrumbIndex: current_active.last_crumb_reached,
                     activeId: current_active.id}
  end

private

  def reached_params
    params.require(:crumb).permit(:id)
  end

  def destroy_params
    params.require(:params).permit(:id)
  end

  def current_trail
    @trail ||= Active.find(params[:id]).trail
  end

  def new_trail
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
    if @trail.priv && !(@trail.password == @active.entered_password)
        redirect_to current_trail,
        alert: "You did not enter the correct password for that trail."
    end
  end

  def published?
    unless @trail.published || (current_user == @trail.creator)
      redirect_to current_user
    end
  end

end
