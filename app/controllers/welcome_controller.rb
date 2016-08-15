class WelcomeController < ApplicationController

  def index
    if params[:query] != nil
      search = PgSearch.multisearch params[:query]
      @trail_search = []
      search.each do |trail|
        	@trail_search << Trail.find(trail.searchable_id)
      end
    end
  end

end
