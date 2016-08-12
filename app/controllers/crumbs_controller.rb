class CrumbsController < ApplicationController

  private

  def current_trail
    @trail = Trail.find(params[:trail_id])
  end


end
