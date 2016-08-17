class TagsController < ApplicationController

  # def index
  #   if params[:search]
  #     @tags = Tag.search(params[:search]).order("created_at DESC")
  #     #where published is true
  #   else
  #     @tags = Tag.order('created_at DESC')
  #     #where published is true
  #     # @errors = ["There are no Tags associated with your search."]
  #   end
  # end

  def show
    @tag = Tag.find(params[:id])

    all = @tag.trails
    @trails = @tag.trails.published
    
  end

end
