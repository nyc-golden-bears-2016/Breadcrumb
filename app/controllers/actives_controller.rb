class ActivesController < ApplicationController
before_action :current_trail, :current_user

def join
  if trail.private
    render '_secret'
  else
    redirect "/active/#{trail.id}"
  end
end

def leave
  attempted = Experience.create(user: user, trail: current_trail)
end

def show
end

def crumb
end

def update
  current_position = {location_params}
end


private

def trail_params
end

def current_trail
end

def current_user
end

def location_params
  params.require(:location).permit(:latitude, :longitude)
end

end
