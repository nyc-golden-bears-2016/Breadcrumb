class TagsController < ApplicationController

  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
    all = @tag.trails
    @trails = @tag.trails.published
  end

end
