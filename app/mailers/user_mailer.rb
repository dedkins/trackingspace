class UserMailer < ActionMailer::Base
  default :from => 'dedkins@trackingspace.com'
  layout 'user_mailer'

  #def newhomevisitor(ip,city,state)
  #  @ip = ip
  #  @city = city
  #  @state = state
  #  mail(:to => 'dedkins@trackingspace.com', :subject => "New Visitor")
  #end

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

  def sponsor_email(sponsor)
    @sponsorid = Sponsor.find(sponsor.id)
    @email = @sponsorid.email
    @url = "http://www.trackingspace.com/sponsors/#{@sponsorid.id}/accept"
    @sponsorurl = "http://www.trackingspace.com/users/#{@sponsorid.sponsoredby_id}"
    mail(:to => @email, :subject => "#{@sponsorid.sponsoredby.name} would like to sponsor you on TrackingSpace")
  end

  def sponsor_accept(sponsor)
    @sponsorid = Sponsor.find(sponsor.id)
    @membertoprofileurl = "http://www.trackingspace.com/users/#{@sponsorid.sponsoredby_id}"
    mail(:to => @sponsorid.sponsoredby.email, :subject => "#{@sponsorid.sponsoredmember.name} has accepted your sponsor request!")
  end


  def leaseshare_email_existing(shared)
    @leaseshareid = LeaseShare.find(shared.id)
    @shared_from = User.find(@leaseshareid.sharedfrom_id)
    @shared_to = User.find(@leaseshareid.sharedto_id)
    @space = Space.find(@leaseshareid.space)
    @email = @shared_to.email
    @buildingurl = "http://www.trackingspace.com/buildings/#{@leaseshareid.space.building.id}"
    @spaceurl = "http://www.trackingspace.com/buildings/#{@leaseshareid.space.building.id}/spaces/#{@leaseshareid.space_id}"
    @sharedurl = "http://www.trackingspace.com/spaces/#{@leaseshareid.space_id}/leases/#{@leaseshareid.lease_id}"
    mail(:to => @email, :subject => "#{@shared_from.name} has shared a lease with you")
  end

  def leaseshare_email(shared)
    @leaseshareid = LeaseShare.find(shared.id)
    @space = Space.find(@leaseshareid.space)
    @shared_from = User.find(@leaseshareid.sharedfrom_id)
    @email = @leaseshareid.email
    @buildingurl = "http://www.trackingspace.com/buildings/#{@leaseshareid.space.building.id}"
    @spaceurl = "http://www.trackingspace.com/buildings/#{@leaseshareid.space.building.id}/spaces/#{@leaseshareid.space_id}"
    @url = "http://www.trackingspace.com/lease_shares/#{@leaseshareid.id}/accept"
    @sharedfromurl = "http://www.trackingspace.com/users/#{@shared_from.id}"
    mail(:to => @email, :subject => "#{@shared_from.name} is sharing a lease with you")
  end
end