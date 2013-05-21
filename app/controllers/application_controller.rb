class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery

before_filter :new_stuff

def new_stuff
  @allnewusers = User.new_users.limit(8).order('created_at desc')
  @allnewbuildings = Building.new_buildings.limit(25)
  @allnewposts = Micropost.where("created_at >= ?", Time.now.prev_month).where(:propmgmt => [false,nil]).where("content != ''").limit(10)
  if user_signed_in?
    @user = User.find(current_user.id)
    @sponsoravail = @user.sponsoravail
    @sponsorcount = Sponsor.where('sponsoredby_id = ?', @user.id).count
    @sponsorleft = @user.sponsorleft
    @leases = @user.leases
    @buildingstracked = @user.building_relationships
    @sponsor_record = Sponsor.find_by_sponsoredmember_id(current_user.id)
    @following = @user.following
    @followers = @user.followers
    if @sponsor_record
      @sponsor = User.find(@sponsor_record.sponsoredby_id)
    end
  end
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

def iPad?
  request.user_agent =~ /iPad/
end
helper_method :iPad?

#layout :which_layout
#  def which_layout
#    mobile_device? ? 'mobile' : 'application'
#  end

end
