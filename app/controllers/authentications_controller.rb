class AuthenticationsController < ApplicationController
  
  def index
    @authentications = current_user.authentications if current_user
  end
  
  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'],omniauth['uid'])
    returnaddress = request.referer
    if authentication
      sign_in_and_redirect(:user, authentication.user)
      flash[:notice] = 'Sign In Successful'
    elsif current_user
      @user = current_user
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = "Authentication successful."
      redirect_to edit_user_registration_path(@user)
    else
      user=User.new
      user.apply_omniauth(omniauth)
      if user.save
        sign_in_and_redirect(:user, user)
        flash[:notice] = 'Sign In Successful'
      else
        session[:omniauth] = omniauth.except('extra')
        redirect_to new_user_registration_url
      end
    end
  end
  
  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
end

end
