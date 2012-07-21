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

def mbuilding_post
	@building = Building.find(params[:building_id])
	@micropost = current_user.microposts.build(params[:micropost])
end

def mspace_post
	@building = Building.find(params[:building_id])
	@space = Space.find(params[:id])
	@micropost = current_user.microposts.build(params[:micropost])
end

def destroy
	@micropost.destroy
	redirect_back_or current_user
end

def buildings_activity
	@buildings = Buildings.all
	@microposts = @buildings.microposts.scoped
	@buildinglist = @microposts.where("created_at > ?", 30.days.ago, :order => "created_at desc")
end

def authorized_user
	@micropost = Micropost.find(params[:id])
	redirect_to root_path unless current_user == @micropost.user
end

end