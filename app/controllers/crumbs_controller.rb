class CrumbsController < ApplicationController
before_action :current_trail, :trail_creator
before_action :current_crumb, only: [:edit, :update, :destroy, :show]

  def new
    @crumb = @trail.crumbs.new
  end

  def create
    @crumb = @trail.crumbs.new(crumb_params)
    if invalid_crumb_spacing(@crumb)
      redirect_to "/trails/#{@trail.id}/crumbs/new",
       alert: "Crumbs have to be spaced at least 30 meters apart"
    elsif @crumb.save
      redirect_to "/trails/#{@trail.id}/edit"
    else
      redirect_to current_user
      #make error handling
    end
  end

  def update
    @crumb.update_attributes(crumb_params)
    redirect_to "/trails/#{@trail.id}/edit"
  end

  def destroy
    @crumb.destroy
    redirect_to "/trails/#{@crumb.trail.id}/edit"
  end


  private

  def current_trail
    @trail = Trail.find(params[:trail_id])
  end

  def current_crumb
    @crumb = Crumb.find(params[:id])
  end

  def trail_creator
    unless current_user == @trail.creator
      redirect_to_root
    end
  end

  def crumb_params
    params.require(:crumb).permit(:name, :description, :latitude, :longitude, :requires_answer, :answer, :order_number, :img)
  end

  def invalid_crumb_spacing(new_crumb)
    unless @trail.crumbs.first.new_record?
      invalid_crumbs = @trail.crumbs[0..-2].select do | crumb |
         Haversine.distance(crumb.latitude, crumb.longitude, new_crumb.latitude, new_crumb.longitude).to_meters < 30
      end
      if invalid_crumbs.empty?
        return false
      else
        new_crumb.destroy
        return true
      end
    end
    return false
  end

end
