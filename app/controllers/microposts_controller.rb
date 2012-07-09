class MicropostsController < ApplicationController
	before_filter :authorized_user, :only => :destroy

def create
	@micropost = current_user.microposts.build(params[:micropost])

	if @micropost.save
		flash[:success] = "Micropost Saved"
		redirect_to current_user
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