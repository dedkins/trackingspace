class PagesController < ApplicationController
	autocomplete :user, :name, :full => true

	before_filter :authenticate_user!, :only => [:upgrade] 

	def index
		if user_signed_in?
			@user = User.find(current_user.id)
			@recent_items = @user.recent
			@feed_items = @user.feed
		end
		@newbuildings24 = Building.new_buildings
		@newbuildings = Building.order('created_at DESC').limit(10)
		@json = Building.new_buildings.to_gmaps4rails
		@feed_items = Micropost.where("user_id IS NOT NULL").order('created_at DESC').limit(10)
	end

	def learnmore
		if user_signed_in?
	      redirect_to home_path
	    else
	      render :layout => 'landing'
	    end
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

	def earlyadopter
	end

	def brokers
		render :layout => false
	end

	def people_main
	    @users = User.last(20).reverse
	    if user_signed_in?
	    	@user = current_user
	    	@feed_items = @user.feed
	    else
	    	@feed_items = Micropost.where("user_id IS NOT NULL").order('created_at DESC').limit(10)
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
