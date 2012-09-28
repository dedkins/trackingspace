class PagesController < ApplicationController
	autocomplete :user, :name, :full => true

	def index
		@newbuildings = Building.new_buildings
		@json = Building.new_buildings.to_gmaps4rails
	end

	def spaces_main
		if user_signed_in?
		@leases = Lease.find_all_by_user_id(current_user.id)
		end
	end

	def people_main
		if !params[:name].nil?
			@user = User.find_by_name(params[:name])
			if @user.id?
	    		redirect_to user_path(@user.id)
	    	else
	    		people_main_path
	    	end
	    end
	end

	def buildings_main
		if user_signed_in?
			@user = User.find(current_user.id)
			@recent_items = @user.recent
		end
	end
	
end
