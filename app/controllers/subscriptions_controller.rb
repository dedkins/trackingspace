class SubscriptionsController < ApplicationController

	before_filter :authenticate_user!
	
	def new
		@user = User.find(current_user.id)
	end

	def create
		#begin
			@user = User.find(current_user.id)
			@subscription = Subscription.new(params[:subscription])
				if @subscription.save_with_payment
					@user.upgrade = @subscription.plan_name
					@user.save!
					UserMailer.upgrade_email(@user).deliver
					UserMailer.upgrade_notification(@user).deliver
				redirect_to @user, :notice => "Thank you for 
				  subscribing!"
				else
				render :new
				end
		#rescue Exception => e
		#	redirect_to upgrade_path
		#end
	end

end
