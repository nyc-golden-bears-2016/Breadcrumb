class WelcomeController < ApplicationController

  def index
    #static page with creators/logo/brief description/register/login
        # logic for search 
    if params[:query] != nil
      search = PgSearch.multisearch params[:query]
      # binding.pry
      @trail_search = []
      search.each do |trail|
        	@trail_search << Trail.find(trail.searchable_id)
      end

    end
  end


end
