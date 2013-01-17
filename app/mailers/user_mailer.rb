class UserMailer < ActionMailer::Base
  default :from => 'dedkins@trackingspace.com'

  def newhomevisitor(ip,city,state)
    @ip = ip
    @city = city
    @state = state
    mail(:to => 'dedkins@trackingspace.com', :subject => "New Visitor")
  end

  def welcome_email(user)
    @user = user
    @url  = "http://www.trackingspace.com/users/sign_in"
    mail(:to => user.email, :bcc => 'dedkins@trackingspace.com', :subject => "Thank you for joining")
  end

  def upgrade_email(user)
    @user = user
    mail(:to => user.email, :bcc => 'dedkins@trackingspace.com', :subject => "Welcome to Greater Benefits")
  end

  def upgrade_notification(user)
    @user = user
    mail(:to => 'dedkins@edkinsgroup.com', :subject => "New Upgrade!")
  end

  def new_building_post(building)
    @building = Building.find(building)
    @micropost = Micropost.where('building_id = ?', @building.id).first
    @user_url = "http://www.trackingspace.com/users/#{@micropost.user.id}"
    @url  = "http://www.trackingspace.com/buildings/#{@building.id}"
    @followers = BuildingRelationship.find_all_by_building_id(@building)
    @users = @followers.map(&:user_id)
    emails = User.find_all_by_id(@users)
    email = emails.map(&:email)
    mail(:bcc => email, :subject => 'New Comment for '+@building.address)
  end

  def propmgmt(building)
    @building = Building.find(building)
    @propmgr = User.find(@building.manager)
    @micropost = Micropost.where('building_id = ? and propmgmt = true', @building.id).first
    @user_url = "http://www.trackingspace.com/users/#{@micropost.user.id}"
    @url  = "http://www.trackingspace.com/buildings/#{@building.id}"
    mail(:to => @propmgr.email, :subject => "New Request for #{@building.address}")
  end

end