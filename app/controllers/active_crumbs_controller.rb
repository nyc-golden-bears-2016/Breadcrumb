class ActiveCrumbsController < ApplicationController
before_action :current_active, :current_active_crumb, :related_crumb
# before_action :redirect, only: [:show]

  def show
    @trail = @active.trail
    if !@crumb.requires_answer && (@crumb.order_number > @active.last_crumb_reached)
      @active.update_attribute(:last_crumb_reached, @crumb.order_number)
    end
  end

  def update
    entered = active_crumb_params[:entered_answer]
    if entered == @crumb.answer && (@crumb.order_number > @active.last_crumb_reached)
      @active.update_attribute(:last_crumb_reached, @crumb.order_number)
      redirect_to "/actives/#{@active.id}"
    else
      redirect_to "/actives/#{@active.id}/active_crumbs/#{@active_crumb.id}"
      #make error handling
    end
  end

  private

  def current_active
    @active = Active.find(params[:active_id])
  end

  def current_active_crumb
    @active_crumb = ActiveCrumb.find(params[:id])
  end

  def related_crumb
    @crumb = @active_crumb.crumb
  end

  # def redirect
  #   #placeholder until there is some marker that you have reached geofence
  #   if @crumb.order_number > @active.last_crumb_reached
  #     redirect_to root
  #   end
  # end

  def active_crumb_params
    params.require(:active_crumb).permit(:entered_answer)
  end

end
