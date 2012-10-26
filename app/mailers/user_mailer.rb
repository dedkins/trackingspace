class UserMailer < ActionMailer::Base

  def welcome_email(user)
    @user = user
    @url  = "http://www.trackingspace.com/sign-in"
    mail(:to => user.email, :subject => "Thank you for joining")
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