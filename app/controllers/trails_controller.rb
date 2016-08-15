class TrailsController < ApplicationController
before_action :current_trail, only: [:edit, :update, :destroy, :show, :publish]
before_action :log_in
before_action :redirect, only: [:edit, :update, :destroy]

  def index
<<<<<<< da46aeb62eb0df29fa1a0e2467d6ee795b1085bf
    # byebug
    @trails = current_user.nearby_trails.page params[:page]
    # available_trails.nearby.order(created_at: :desc)
=======
    @trails = Trail.where(published: true, private: false).page params[:page]
    # @trails = Trail.text_search(params[:query]).page(params[:page]).per_page(1)
    # available_trails.nearby
    # available_trails.order(created_at: :desc)
>>>>>>> get basic search to work on console
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
    @trail.update_attribute(:published, true)
    @trail.order_crumbs
    redirect_to current_user
  end

  def destroy
    @trail.destroy
    redirect_to current_user
  end

private



  def trail_params
    params.require(:trail).permit(:name, :description, :latitude, :longitude, :private, :sequential, :published, :password, :img)
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
   unless current_user == @trail.creator
     redirect_to new_user_session_path
   end
  end

end
