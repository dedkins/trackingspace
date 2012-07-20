class MicropostsController < ApplicationController
	before_filter :authorized_user, :only => :destroy

def create
	@micropost = current_user.microposts.build(params[:micropost])
	@back_to = params[:back_to]

	if @micropost.save
		flash[:success] = "Micropost Saved"
		redirect_to @back_to
	else
		render current_user
	end
end

def mobile_post
	@building = Building.find(params[:building_id])
	@micropost = current_user.microposts.build(params[:micropost])
	@back_to = params[:back_to]

	if @micropost.save
		flash[:success] = "Micropost Saved"
		redirect_to @back_to
	else
		render current_user
	end
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