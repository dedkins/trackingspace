class UserMailer < ActionMailer::Base
  default :from => 'dedkins@trackingspace.com'

  def welcome_email(user)
    @user = user
    @url  = "http://www.trackingspace.com/users/sign_in"
    mail(:to => user.email, :cc => 'dedkins@trackingspace.com', :subject => "Thank you for joining")
  end

  def upgrade_email(user)
    @user = user
    mail(:to => user.email, :subject => "Welcome to Greater Benefits")
  end

  def upgrade_notification(user)
    @user = user
    mail(:to => 'dedkins@edkinsgroup.com', :subject => "New Upgrade!")
  end

end