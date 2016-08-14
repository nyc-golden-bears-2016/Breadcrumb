class ActivesController < ApplicationController
before_action :log_in
before_action :current_trail, except: [:join, :joined, :crumb]
before_action :current_active, :correct_password, only: [:show, :crumb, :update, :destroy]
before_action :correct_password, only: [:show, :crumb, :update]
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
    #can we call the last crumb they hit and mark it as a save point?
    # made a new column in the experience model to hold that info
  end

  def crumb
    #this route is nested, finding the trail is different
    @trail = Active.find(params[:active_id]).trail
    @crumb = Crumb.find(params[:id])
  end

  def answered
    entered = locked_crumb_params[:entered_answer]
    if entered == @crumb.answer
      @active = Active.update_attribute(entered_answer: entered, last_crumb_reached: @crumb.order_number + 1)
      redirect_to "/actives/#{@active.id}"
    else
      redirect_to "/actives/#{@active.id}"
      #make error handling
    end
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

end
