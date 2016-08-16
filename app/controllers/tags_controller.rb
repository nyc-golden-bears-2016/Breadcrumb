class TagsController < ApplicationController

  def index
    if params[:search]
      @tags = Tag.search(params[:search]).order("created_at DESC")
      #where published is true
    else
      @tags = Tag.order('created_at DESC')
      #where published is true
    end

  end

  def show
    @tag = Tag.find(params[:id])
    @trails = @tag.trails
  end

end
