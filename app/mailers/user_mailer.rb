class UserMailer < ActionMailer::Base
  default from: "dedkins@trackingspace.com"

  def welcome_email(user)
    @user = user
    @url  = "http://www.trackingspace.com/sign-in"
    mail(:to => user.email, :cc => "dedkins@trackingspace.com", :subject => "Thank you for joining")
  end

end