class TrailsController < ApplicationController

  def index
    available_trails = Trail.where(published: true, public:true)
    available_trails.nearby
    #find out nearby method
    available_trails.order(created_at: :desc)
    @trails = available_trails.paginate
  end


private

  def trail_params
    params.require(:trail).permit(:latitude, :longitude)
  end

end
