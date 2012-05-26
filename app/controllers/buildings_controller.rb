class BuildingsController < ApplicationController
  # GET /buildings
  # GET /buildings.json
  
  
  def index
    @buildings = Building.all
    @json = Building.all.to_gmaps4rails

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @buildings }
    end
  end

  # GET /buildings/1
  # GET /buildings/1.json
  def show
    @building = Building.find(params[:id])
    @json = Building.find(@building.id).to_gmaps4rails

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @building }
    end
  end

  # GET /buildings/new
  # GET /buildings/new.json
  def new
    @building = Building.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @building }
    end
  end

  # GET /buildings/1/edit
  def edit
    @building = Building.find(params[:id])
  end
  
  
  # POST /buildings
  # POST /buildings.json
  
  def create
    @building = Building.new
    @building.address = params[:building][:address]
    @building.latitude = params[:building][:latitude]
    @building.longitude = params[:building][:longitude]
    
    @building = Building.find_or_initialize_by_address(:address => @building.address,:latitude => @building.latitude,:longitude => @building.longitude)
    
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

  # PUT /buildings/1
  # PUT /buildings/1.json
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

  # DELETE /buildings/1
  # DELETE /buildings/1.json
  def destroy
    @building = Building.find(params[:id])
    @building.destroy

    respond_to do |format|
      format.html { redirect_to buildings_url }
      format.json { head :no_content }
    end
  end
end
