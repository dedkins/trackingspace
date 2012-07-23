class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery

private 

def store_location
	session[:return_to] = request.fullpath
end

def clear_return_to
	session[:return_to] = nil
end

def mobile_device?
	request.user_agent =~ /Mobile|webOS/
end
helper_method :mobile_device?

layout :which_layout
  def which_layout
    mobile_device? ? 'mobile' : 'application'
  end

end
