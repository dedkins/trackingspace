class BuildingsController < ApplicationController

  def index
    @user = User.find(current_user.id)
    @buildings = Building.all(:order => "created_at desc")
    @newbuildings = Building.new_buildings
    @json = Building.new_buildings.to_gmaps4rails
    @recent_items = @user.recent

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @buildings }
    end
  end

  def show
    @user = User.find(current_user.id)
    @building = Building.find(params[:id])
    @spaces = Space.find_all_by_building_id(@building.id)
    @new_space = @building.spaces.build
    @json = Building.find(@building.id).to_gmaps4rails

    @micropost = Micropost.new if signed_in?
    @feed_items = @building.feed
    @recent_items = @user.recent
    
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
      redirect_to buildings_path
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
