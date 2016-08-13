class TrailsController < ApplicationController
before_action :current_trail, only: [:edit, :update, :destroy, :show]
before_action :log_in, only: [:new ]
before_action :redirect, only: [:edit, :update, :destroy]
  def index
    @trails = Trail.where(published: true, private: false).page params[:page]
    # available_trails.nearby.order(created_at: :desc)
  end

  def new
    @trail = current_user.created_trails.new
  end

  def create
  @trail = current_user.created_trails.new(trail_params)
    if @trail.save
      redirect_to "/trails/#{@trail.id}/edit"
    else
      redirect_to current_user
      #make error handling
    end
  end

  def edit
    # if !@trail.published
      @tags = Tag.all.map {|t| t.subject }
      @image = Image.new
    # else
    #   redirect_to current_user
    #   #make error handling - you cannot edit a published trail
    # end
  end

  def show
    #initialize map with user and either first crumb or all crumbs
    #links for each crumb on the page appear but do not work until you enter the area
  end

  def update
    @tag = @trail.tags.new
    #creates and redirects user to user show page with new trail
    #if trail is private and user is creator, the password should appear next to the trail so that they can easily send it out & we don't have to handle missing passwords
  end

  def publish
    if @trail.all_true == true
      @trail.published = true
      redirect_to current_user
    else
      redirect_to root
      #make error handling
    end
  end

  def destroy
  end

private

  def trail_params
    params.require(:trail).permit(:name, :description, :latitude, :longitude, :private, :sequential, :published, :password)
  end

  def current_trail
    @trail = Trail.find(params[:id])
  end

  def log_in
    if !current_user
      redirect_to new_user_session_path
    end
  end

  def redirect
   if !(current_user = @trail.creator)
     redirect_to new_user_session_path
   end
  end

end
