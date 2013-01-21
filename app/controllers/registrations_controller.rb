class RegistrationsController < Devise::RegistrationsController

	layout false

	def new 
	end

	def edit
		@user = User.find(current_user.id)
		@authentications = Authentication.find_all_by_user_id(@user.id)
		super
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
