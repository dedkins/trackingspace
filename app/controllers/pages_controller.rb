class PagesController < ApplicationController

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
	end

	def buildings_main
		if user_signed_in?
			@user = User.find(current_user.id)
			@recent_items = @user.recent
		end
	end
	
end
