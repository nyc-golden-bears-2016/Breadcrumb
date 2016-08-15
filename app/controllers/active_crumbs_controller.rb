class ActiveCrumbsController < ApplicationController
before_action :current_active, :current_active_crumb, :related_crumb

  def show
    @trail = @active.trail
    if !@crumb.requires_answer && (@crumb.order_number > @active.last_crumb_reached)
      @active.update_attribute(:last_crumb_reached, @active_crumb.order_number)
    end
  end

  def update
    entered = active_crumb_params[:entered_answer]
    if entered == @crumb.answer
      @active.update_attribute(:last_crumb_reached, @active_crumb.order_number)
      redirect_to "/actives/#{@active.id}"
    else
      redirect_to "/actives/#{@active.id}/crumbs/#{@crumb.id}"
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

  def active_crumb_params
    params.require(:active_crumb).permit(:entered_answer)
  end

end
