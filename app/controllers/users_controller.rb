class UsersController < ApplicationController
before_action :redirect

  def show
    #unpublished trails - link to edit
    #published trails - private have password next to it
    #walked trails
    #perhaps tags that are interests?
    @trails = Trail.where(published: true).page params[:page]
    @page = User.find(params[:id]).username
  end


  private

  def redirect
   if !current_user
     redirect_to new_user_session_path, notice: 'You are not logged in.'
   end
  end

end
