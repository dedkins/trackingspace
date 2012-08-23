class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery

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
	request.user_agent =~ /iP(?:hone|ad|od)/
end
helper_method :mobile_device?

#layout :which_layout
#  def which_layout
#    mobile_device? ? 'mobile' : 'application'
#  end

end
