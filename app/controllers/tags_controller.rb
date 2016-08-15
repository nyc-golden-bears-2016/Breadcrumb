class TagsController < ApplicationController

  def index
    #static page with creators/logo/brief description/register/login
        # logic for search 
  @tags = Tag.all
  if params[:search]
    @tags = Tag.search(params[:search]).order("created_at DESC")
  else
    @tags = Tag.all.order('created_at DESC')
  end
  end

end
