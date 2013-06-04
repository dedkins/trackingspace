class BuildingsController < ApplicationController

  def index
    if user_signed_in?
      @user = User.find(current_user.id)
      @recent_items = @user.recent
    end
    @buildings = Building.all(:order => "created_at desc")
    @newbuildings24 = Building.new_buildings.limit(10)
    @newbuildings = Building.order('created_at DESC').limit(10)
    @json = Building.new_buildings.to_gmaps4rails do |building, marker|
      marker.json "\"buildings\": #{building.id}"
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @buildings }
    end
  end

  def show
    if mobile_device?
     redirect_to(mobilebuilding_path) and return
    end
    if user_signed_in?
      @user = User.find(current_user.id)
      if params[:id].present?
      @building = Building.find(params[:id])
      end
      if params[:slug].present?
        @building = Building.find_by_slug(params[:slug])
      end
      @recent_items = @user.recent
      @user_ad_availability = Ad.find_by_building_id_and_user_id(@building.id,@user.id)
    end
    if params[:id].present?
      @building = Building.find(params[:id])
      end
    if params[:slug].present?
        @building = Building.find_by_slug(params[:slug])
      end
    @ad_slot1 = Ad.find_by_building_id_and_slot(@building.id,'1')
    @ad_slot2 = Ad.find_by_building_id_and_slot(@building.id,'2')
    @ad_slot3 = Ad.find_by_building_id_and_slot(@building.id,'3')
    @spaces = Space.find_all_by_building_id(@building.id)
    @percent_leased = Space.find_all_by_building_id_and_status(@building.id, 'status = leased')
    @new_space = @building.spaces.build
    @json = Building.find(@building.id).to_gmaps4rails
    @newbuildings = Building.order('created_at DESC').limit(10)

    @micropost = Micropost.new if signed_in?
    @feed_items = @building.feed
    
    respond_to do |format|
      if user_signed_in?  
        @last_recent = BuildingOrder.find_by_user_id_and_building_id(current_user,@building.id)
          if @last_recent != nil
            @last_recent.delete
          end
        BuildingOrder.create!(building_id: @building.id, user_id: current_user.id)
      end
      format.html # show.html.erb
      format.json { render json: @building }
    end
  end

  def new
    @building = Building.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @building }
    end
  end

  def edit
    @building = Building.find(params[:id])
  end

  def map
  end

  def mobile_building_show
    if params[:id].present?
      @building = Building.find(params[:id])
      end
    if params[:slug].present?
        @building = Building.find_by_slug(params[:slug])
      end
      @spaces = Space.find_all_by_building_id(@building.id)
    @json = Building.find(@building.id).to_gmaps4rails
  end
  def mapview
    @building = Building.find(params[:id])
    @json = Building.find(@building.id).to_gmaps4rails
    respond_to do |format|
      format.json { render json: @building }
      format.js
    end
  end

  def videoview
    @building = Building.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def addvideo
    @building = Building.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def spacesview
    @building = Building.find(params[:id])
    @spaces = Space.find_all_by_building_id(@building.id)
    respond_to do |format|
      format.js
    end
  end
  
  def newspace
    @building = Building.find(params[:id])
    @space = Space.new
    respond_to do |format|
      format.js
    end
  end

  def management
    @micropost = Micropost.new if signed_in?
    @building = Building.find(params[:id])
    if @building.manager
      @manager = User.find(@building.manager)
    end
    @feed_items = Micropost.find_all_by_building_id_and_propmgmt(@building.id,true)
    respond_to do |format|
      format.js
    end
  end

  def claimpropmgmt
    @micropost = Micropost.new if signed_in?
    @user = User.find(current_user.id)
    @building = Building.find(params[:id])
    @building.manager = @user.id
    @building.save!
    @manager = User.find(@building.manager)
    respond_to do |format|
      format.js
    end
  end

  def home
    if user_signed_in?
      redirect_to home_path
    else
      render :layout => "home_html"
    end
  end

  def create
    @building = Building.new
    @building.address = params[:building][:address]
    @building.latitude = params[:building][:latitude]
    @building.longitude = params[:building][:longitude]
    @building.street_number = params[:building][:street_number]
    @building.route = params[:building][:route]
    @building.locality = params[:building][:locality]
    @building.administrative_area_level_1 = params[:building][:administrative_area_level_1]
    @building.administrative_area_level_2 = params[:building][:administrative_area_level_2]
    @building.postal_code = params[:building][:postal_code]
    @building.country = params[:building][:country]
    @building.slug = @building.street_number+'-'+@building.route.parameterize+'-'+@building.locality.parameterize+'-'+@building.administrative_area_level_1.parameterize
    
    if user_signed_in?
      @building = Building.find_or_initialize_by_address(:address => @building.address,:user_id => current_user.id, :latitude => @building.latitude,:longitude => @building.longitude,:street_number => @building.street_number,:slug => @building.slug,:locality => @building.locality,:administrative_area_level_1 => @building.administrative_area_level_1,:administrative_area_level_2 => @building.administrative_area_level_2,:postal_code => @building.postal_code,:country => @building.country)
    else
      @building = Building.find_or_initialize_by_address(:address => @building.address,:latitude => @building.latitude,:longitude => @building.longitude,:street_number => @building.street_number,:slug => @building.slug,:locality => @building.locality,:administrative_area_level_1 => @building.administrative_area_level_1,:administrative_area_level_2 => @building.administrative_area_level_2,:postal_code => @building.postal_code,:country => @building.country)
    end

      respond_to do |format|
        if @building.save
          format.html { redirect_to @building, notice: 'Building was successfully created.' }
          format.json { render json: @building, status: :created, location: @building }
        else
          format.html { render action: "new" }
          format.json { render json: @building.errors, status: :unprocessable_entity }
        end
      end
  end

  def update
    @building = Building.find(params[:id])
    if params[:video].present?
    @micropost = current_user.microposts.build(typeof: 'Updated', content: 'Added a new video', building_id: @building.id,name: @current_user.name)
    else
    @micropost = current_user.microposts.build(typeof: 'Updated', building_id: @building.id,name: @current_user.name)
    end

    respond_to do |format|
      if @building.update_attributes(params[:building])
        @micropost.save!
        format.html { redirect_to @building, notice: 'Building was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @building.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @building = Building.find(params[:id])
    @building.destroy

    respond_to do |format|
      format.html { redirect_to buildings_url }
      format.json { head :no_content }
    end
  end

end
