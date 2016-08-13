class TrailsController < ApplicationController
before_action :redirect
before_action :current_trail, only: [:edit]
  def index
    @trails = Trail.where(published: true, private: false).page params[:page]
    # available_trails.nearby
    # available_trails.order(created_at: :desc)
  end

  def new
    #form for new trail - name, description, private, form to add crumb, add tags
    #delete, save, or publish at any time
    @trail = current_user.created_trails.new
  end

  def create
  @trail = current_user.created_trails.new(trail_params)
    if @trail.save
      redirect_to "/trails/#{@trail.id}/edit"
    else
      render '_errors'
    end
  end

  def edit
    @tags = Tag.all
    @tag = @trail.tags.new
    #only unpublished trails can be edited
    #add error message of 'trail already published and refresh'
    #else, load page and show form
  end

  def show
    #initialize map with user and either first crumb or all crumbs
    #links for each crumb on the page appear but do not work until you enter the area
  end

  def update
    #creates and redirects user to user show page with new trail
    #if trail is private and user is creator, the password should appear next to the trail so that they can easily send it out & we don't have to handle missing passwords
  end

  def publish
    #makes published true so it can appear publicly
    @trail.published = true
  end

  def destroy
  end

private

  def trail_params
    params.require(:trail).permit(:name, :description)
  end

  def current_trail
    @trail = Trail.find(params[:id])
  end

  def published?
    !!current_trail.published
  end

  def redirect
   if !current_user
     redirect_to new_user_session_path, notice: 'You are not logged in.'
   end
  end

end
