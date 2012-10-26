class SubscriptionsController < ApplicationController
	
	def new
	end

	def create
	@user = User.find(current_user.id)
	@subscription = Subscription.new(params[:subscription])
		if @subscription.save_with_payment
			@user.upgrade = 'Upgrade59'
			@user.save!
			UserMailer.upgrade_email(@user).deliver
			UserMailer.upgrade_notification(@user).deliver
		redirect_to @user, :notice => "Thank you for 
		  subscribing!"
		else
		render :new
		end
	end

end
