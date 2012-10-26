class PagesController < ApplicationController
	autocomplete :user, :name, :full => true

	def index
		if user_signed_in?
			@user = User.find(current_user.id)
			@recent_items = @user.recent
		end
		@newbuildings24 = Building.new_buildings
		@newbuildings = Building.order('created_at DESC').limit(10)
		@json = Building.new_buildings.to_gmaps4rails
		@feed_items = Micropost.order('created_at DESC').limit(10)
	end

	def spaces_main
		if user_signed_in?
		@leases = Lease.find_all_by_user_id(current_user.id)
		end
	end

	def privacy
	end

	def upgrade
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
	    @new_users = User.order('created_at DESC').limit(10)
	    if user_signed_in?
	    	@user = current_user
	    	@feed_items = @user.feed
	    else
	    	@feed_items = Micropost.order('created_at DESC').limit(10)
	    end
	end

	def buildings_main
		if user_signed_in?
			@user = User.find(current_user.id)
			@recent_items = @user.recent
			@feed_items = @user.building_feed
		end
		@newbuildings = Building.order('created_at DESC').limit(10)
		@feed_items = Micropost.where("building_id IS NOT NULL").order('created_at DESC').limit(10)
	end
	
end
