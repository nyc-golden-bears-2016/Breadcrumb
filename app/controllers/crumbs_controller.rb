class CrumbsController < ApplicationController
before_action :current_trail
before_action :current_crumb, only: [:edit, :update, :destroy, :show]
before_action :trail_creator, only: [:show]

  def new
    @crumb = @trail.crumbs.new
  end

  def create
    @crumb = @trail.crumbs.new(crumb_params.merge(order_number: @trail.crumbs.length))
    if invalid_crumb_spacing(@crumb)
      byebug
      redirect_to current_user
      #make error handling
    elsif @crumb.save
      redirect_to "/trails/#{@trail.id}/edit"
    else
      redirect_to current_user
      #make error handling
    end
  end

  def show
  end

  def edit
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
    if current_user == @trail.creator
      true
    else
      redirect_to_root
    end
  end

  def crumb_params
    params.require(:crumb).permit(:name, :description, :latitude, :longitude, :requires_answer, :answer, :order_number, :img)
  end

  def invalid_crumb_spacing(new_crumb)
    unless @trail.crumbs.first.new_record?
      invalid_crumbs = @trail.crumbs[0..-1].select do | crumb |
         Haversine.distance(crumb.latitude, crumb.longitude, new_crumb.latitude, new_crumb.longitude).to_meters < 30
      end
      if invalid_crumbs.empty?
        return false
      else
        return true
      end
    end
    return false
  end

end
