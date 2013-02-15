class PagesController < ApplicationController
	autocomplete :user, :name, :full => true

	before_filter :authenticate_user!, :only => [:newpeople,:sponsored,:upgrade,:upgrade1,:upgrade5,:upgrade30,:upgrade100] 

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

	def people_main
	    @users = User.find(:all, :order => "created_at desc", :limit => 5 )
	    if user_signed_in?
	    	@user = current_user
	    	@feed_items = @user.feed
	    	@local = User.near("#{current_user.latitude},#{current_user.longitude}",50, :order => "created_at desc", :limit => 5)
	    else
	    	@feed_items = Micropost.where("user_id IS NOT NULL").order('created_at DESC').limit(10)
	    	s = Geocoder.search(request.ip)
			@lat = s[0].latitude
			@lon = s[0].longitude
	    	@local = User.near("#{@lat},#{@lon}",50, :order => "created_at desc", :limit => 5)
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

	def sponsored
		@list = Sponsor.where('sponsoredby_id = ? and sponsoredmember_id IS NOT NULL', current_user.id).all
		@pending = Sponsor.where('sponsoredby_id = ? and sponsoredmember_id IS NULL', current_user.id)
	end

	def upgrade
	end

	def upgrade1
	end

	def upgrade5
	end

	def upgrade30
	end

	def upgrade100
	end

	def earlyadopter
	end

	def brokers
		render :layout => false
	end

	
	
end
