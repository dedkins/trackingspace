class RegistrationsController < Devise::RegistrationsController

	def new 

	end

	def create
		@user = User.new(params[:user])

		if @user.save!
			UserMailer.welcome_email(@user).deliver
			sign_in_and_redirect(:user, @user)
		end
		session[:omniauth] = nil unless @user.new_record?
	end

	private

	def build_resource(*args)
		super
		if session[:omniauth]
			@user.apply_omniauth(session[:omniauth])
			@user.valid?
		end
	end
end
