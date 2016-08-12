class TrailsController < ApplicationController

  def index
    #make method to show trails that are published, recent, and (if user has
    #current location), base it around location
    #use pagination gem
    #have form to search
    #private trails will not show description, but instead list 'private'
    available_trails = Trail.where(published: true, public:true)
    # available_trails.nearby
    # available_trails.order(created_at: :desc)
    # @trails = available_trails.paginate
  end

  def new
    #form for new trail - name, description, private, form to add crumb, add tags
    #delete, save, or publish at any time
  end

  def new
    #how will we handle selecting multiple tags?
  end

  def edit
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
  end

  def destroy
  end

private

  def trail_params
    params.require(:trail).permit(:latitude, :longitude)
  end

end
