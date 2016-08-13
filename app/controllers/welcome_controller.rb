class WelcomeController < ApplicationController

  def index
    #static page with creators/logo/brief description/register/login
        # logic for search 
    if params[:query] != nil
      results = PgSearch.multisearch params[:query]
      @results = []
      results.each do |result|
        @results << Trail.find(result.searchable_id)
        # binding.pry
      end
      redirect_to root_path
    end
  end


end
