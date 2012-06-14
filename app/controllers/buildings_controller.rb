class BuildingsController < ApplicationController

  
  def index
    @buildings = Building.all
    @json = Building.all.to_gmaps4rails

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @buildings }
    end
  end

  def show
    @building = Building.find(params[:id])
    @spaces = Space.find_all_by_building_id(@building.id)
    @new_space = @building.spaces.build
    @json = Building.find(@building.id).to_gmaps4rails

    respond_to do |format|
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

    respond_to do |format|
      if @building.update_attributes(params[:building])
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
