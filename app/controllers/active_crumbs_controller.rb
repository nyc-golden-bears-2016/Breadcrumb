class ActiveCrumbsController < ApplicationController
before_action :current_active, :current_active_crumb, :related_crumb, :published?
before_action :redirect, only: [:show]

  def show
    @trail = @active.trail
    if @crumb.requires_answer && (@active_crumb.entered_answer != @crumb.answer.downcase)
      @needs_answer = true
    end
    if @trail.sequential && (@trail.crumbs.length == @active.last_crumb_reached) && (@trail.crumbs.length > 1)
      @message = true
    end
    #for testing
    # @active.update_attribute(:last_crumb_reached, @active_crumb.order_number)
  end

  def update
    entered = active_crumb_params[:entered_answer]
    if entered && (entered.downcase == @crumb.answer.downcase)
      @active_crumb.update_attribute(:entered_answer, entered.downcase)
      redirect_to "/actives/#{@active.id}/active_crumbs/#{@active_crumb.id}",
      alert: "Correct answer!"
    else
      redirect_to "/actives/#{@active.id}/active_crumbs/#{@active_crumb.id}",
      alert: "Incorrect answer."
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

  def redirect
    if @active_crumb.order_number > @active.last_crumb_reached
      redirect_to @active
    end
  end

  def active_crumb_params
    params.require(:active_crumb).permit(:entered_answer)
  end

  def published?
    unless @active.trail.published || (current_user == @active.trail.creator)
      redirect_to current_user
    end
  end
end
