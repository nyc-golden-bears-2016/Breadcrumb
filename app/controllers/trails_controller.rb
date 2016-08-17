class TrailsController < ApplicationController
before_action :current_trail, only: [:edit, :update, :destroy, :show, :publish, :addtag, :removetag]
before_action :log_in
before_action :redirect, only: [:edit, :update, :destroy]
before_action :already_published, only: [:edit, :update]

  def index
    @published_trails = Trail.published.order(created_at: :desc)

    if params[:query] != nil
      search = PgSearch.multisearch params[:query]
      @found_trails_or_tags = []
      search.each do |found_trail_or_tag|
        if found_trail_or_tag.searchable_type == "Trail"
          @found_trails_or_tags << Trail.find(found_trail_or_tag.searchable_id)
        elsif found_trail_or_tag.searchable_type == "Tag"
          @found_trails_or_tags << Tag.find(found_trail_or_tag.searchable_id)
        else
          @error = []
        end
      end
      @found_tags = []
      @found_trails = []
      @found_trails_or_tags.each do |trail_or_tag|
        if trail_or_tag.class == Tag
          @found_tags << Tag.find(trail_or_tag.id)
        else trail_or_tag.class == Trail
          if Trail.find(trail_or_tag).published
          @found_trails << Trail.find(trail_or_tag.id)
          end
        end
      end
    end
  end

  def new
    @trail = current_user.created_trails.new
  end

  def create
  @trail = current_user.created_trails.new(trail_params)
    if @trail.save
      redirect_to "/trails/#{@trail.id}/edit"
    else
      redirect_to current_user,
      alert: "Errors."
    end
  end

  def edit
      @your_tags = TagTrail.where(trail: @trail)
      @other_tags = Tag.all
  end

  def update
    @trail.update_attributes(trail_params)
    redirect_to current_user
  end

  def removetag
    tag = Tag.find(params[:tag_id])
    t = TagTrail.find_by(trail: @trail, tag: tag)
    t.destroy
    render json: {tag: params[:tag_id], trail: @trail.id}
  end

  def addtag
    tag = Tag.find(params[:tag_id])
    if !TagTrail.find_by(trail: @trail, tag: tag)
      @tt = TagTrail.create(trail: @trail, tag: tag)
      render json: {tag_trail: "/trails/#{@tt.trail_id}/remove/#{@tt.tag_id}", tag: tag.subject}
    end
  end

  def publish
    if @trail.too_many_crumbs
      redirect_to edit_trail_path,
      alert: "Please make sure your trail has between one and twenty crumbs."
    else
      @trail.update_attribute(:published, true)
      @trail.order_crumbs
      redirect_to current_user
    end
  end

  def destroy
    @trail.destroy
    render json: params[:id]
  end

  def placed_crumbs
    render :json => {crumbs: current_trail.crumbs }
  end


private

  def trail_params
    params.require(:trail).permit(:name, :description, :latitude, :longitude, :priv, :published, :password, :img)
  end

  def destroy_params
    params.require(:params).permit(:id)
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

  def already_published
    if @trail.published
      redirect_to current_user,
      alert: "Cannot change a published trail."
    end
  end

end
