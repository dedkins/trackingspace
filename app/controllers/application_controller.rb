class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery

before_filter :new_stuff

def new_stuff
  @allnewusers = User.new_users.limit(15)
  @allnewbuildings = Building.new_buildings.limit(15)
  @allnewposts = Micropost.new_posts.limit(10)
end

private 

def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
end

def store_location
	session[:return_to] = request.fullpath
end

def clear_return_to
	session[:return_to] = nil
end

def mobile_device?
	request.user_agent =~ /Mobile|webOS/ && !(request.user_agent =~ /iPad/)
end
helper_method :mobile_device?

#layout :which_layout
#  def which_layout
#    mobile_device? ? 'mobile' : 'application'
#  end

end
