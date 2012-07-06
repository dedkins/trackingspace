class MicropostsController < ApplicationController

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
end

end