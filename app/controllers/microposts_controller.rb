class MicropostsController < ApplicationController
	before_filter :authorized_user, :only => :destroy

def create
	@micropost = current_user.microposts.build(params[:micropost])
	@back_to = params[:back_to]
	
	if @micropost.save
		if @micropost.building_id.present? and @micropost.content.present? and @micropost.propmgmt = false
			@building = Building.find(@micropost.building_id)
			UserMailer.new_building_post(@building).deliver
		end
		if @micropost.propmgmt = true
			@building = Building.find(@micropost.building_id)
			UserMailer.propmgmt(@building).deliver
		end
		redirect_to @back_to
	else
		render current_user
	end
end

def mbuilding_post
	@building = Building.find(params[:building_id])
	@micropost = current_user.microposts.build(params[:micropost])

	respond_to do |format|               
      format.js
    end 
end

def mspace_post
	@building = Building.find(params[:building_id])
	@space = Space.find(params[:id])
	@micropost = current_user.microposts.build(params[:micropost])
end

def destroy
	@micropost.destroy
	session[:return_to] ||= request.referer
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