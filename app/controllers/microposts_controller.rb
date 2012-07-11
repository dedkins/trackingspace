class MicropostsController < ApplicationController
	before_filter :authorized_user, :only => :destroy

def create
	@micropost = current_user.microposts.build(params[:micropost])

	if @micropost.save
		flash[:success] = "Micropost Saved"
	else
		render current_user
	end
end

def mobile_post
	@building = Building.find(params[:building_id])
	@micropost = current_user.microposts.build(params[:micropost])
end

def destroy
	@micropost.destroy
	redirect_back_or current_user
end

def authorized_user
	@micropost = Micropost.find(params[:id])
	redirect_to root_path unless current_user == @micropost.user
end

end