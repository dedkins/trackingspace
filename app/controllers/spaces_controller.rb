class SpacesController < ApplicationController


  # GET /spaces
  # GET /spaces.json

  def index
    @spaces = @building.spaces.all
  end

  before_filter :load_building

  # GET /spaces/1
  # GET /spaces/1.json
  def show
    @space = Space.find(params[:id])
  end

  # GET /spaces/new
  # GET /spaces/new.json
  def new
    @space = Space.new 
  end

  # GET /spaces/1/edit
  def edit
    @space = Space.find(params[:id])
  end

  # POST /spaces
  # POST /spaces.json
  
  def create
    @space = @building.spaces.new(params[:space])

    respond_to do |format|
      if @space.save
        format.html { redirect_to [@building, @space], notice: 'Space was successfully created.' }
        format.json { render json: [@building, @space], status: :created, location: @space }
      else
        format.html { render action: "new" }
        format.json { render json: @space.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /spaces/1
  # PUT /spaces/1.json
  def update
    @space = Space.find(params[:id])

    respond_to do |format|
      if @space.update_attributes(params[:space])
        format.html { redirect_to [@building,@space], notice: 'Space was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @space.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spaces/1
  # DELETE /spaces/1.json
  def destroy
    @space = @building.spaces.find(params[:id])
    @space.destroy

    respond_to do |format|
      format.html { redirect_to building_spaces_path(@building) }
      format.json { head :no_content }
    end
  end

  private

  def load_building
    @building = Building.find(params[:building_id])
  end

end
