class UserRelationshipsController < ApplicationController

	before_filter :authenticate_user!

	def create
		@user = User.find(params[:user_relationship][:followed_id])
		@follower = User.find(current_user.id)
		@record = current_user.follow!(@user)
		UserMailer.new_follower(@record).deliver
		respond_to do |format|
			format.html { redirect_to @user }
			format.js
		end
	end

	def destroy
		@user = UserRelationship.find(params[:id]).followed
		current_user.unfollow!(@user)
		respond_to do |format|
			format.html { redirect_to @user }
			format.js
		end
	end

end
