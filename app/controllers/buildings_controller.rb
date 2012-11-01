class BuildingsController < ApplicationController

  def index
    if user_signed_in?
      @user = User.find(current_user.id)
      @recent_items = @user.recent
    end
    @buildings = Building.all(:order => "created_at desc")
    @newbuildings24 = Building.new_buildings.limit
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
    if user_signed_in?
      @user = User.find(current_user.id)
      @building = Building.find(params[:id])
      @recent_items = @user.recent
      @user_ad_availability = Ad.find_by_building_id_and_user_id(@building.id,@user.id)
    end
    @building = Building.find(params[:id])
    @ad_slot1 = Ad.find_by_building_id_and_slot(@building.id,'1')
    @ad_slot2 = Ad.find_by_building_id_and_slot(@building.id,'2')
    @ad_slot3 = Ad.find_by_building_id_and_slot(@building.id,'3')
    @spaces = Space.find_all_by_building_id(@building.id)
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
    
    if user_signed_in?
      @building = Building.find_or_initialize_by_address(:address => @building.address,:user_id => current_user.id, :latitude => @building.latitude,:longitude => @building.longitude)
    else
      @building = Building.find_or_initialize_by_address(:address => @building.address,:latitude => @building.latitude,:longitude => @building.longitude)
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
    @micropost = current_user.microposts.build(typeof: 'Updated', building_id: @building.id,name: @current_user.name)

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
