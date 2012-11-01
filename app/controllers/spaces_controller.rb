class SpacesController < ApplicationController


  before_filter :load_building

  # GET /spaces
  # GET /spaces.json

  def index
    @spaces = @building.spaces
  end

  # GET /spaces/1
  # GET /spaces/1.json
  def show
    @user = User.find(current_user.id)
    @space = Space.find(params[:id])
    @micropost = Micropost.new if signed_in?
    @feed_items = @space.feed
    @leases = Lease.find_all_by_space_id(params[:id])
    @ad_slot1 = Ad.find_by_space_id_and_slot(@space.id,'s1')
    @ad_slot2 = Ad.find_by_space_id_and_slot(@space.id,'s2')
    @ad_slot3 = Ad.find_by_space_id_and_slot(@space.id,'s3')
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
    @user = current_user
    @space = @building.spaces.new(params[:space])
    @micropost = current_user.microposts.build(typeof: 'Created', building_id: @building.id,space_id: @space.id,address: @building.address,name: @user.name, suite: @space.suite)

    respond_to do |format|
      if @space.save
        @micropost.save!
        format.html { redirect_to [@building], notice: 'Space was successfully created.' }
        format.json { render json: [@building], status: :created, location: @space }
      else
        format.html { render action: "new" }
        format.json { render json: @space.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /spaces/1
  # PUT /spaces/1.json
  def update
    @user = current_user
    @space = Space.find(params[:id])
    @micropost = current_user.microposts.build(typeof: 'Updated', building_id: @building.id,space_id: @space.id,address: @building.address,name: @user.name, suite: @space.suite)

    respond_to do |format|
      if @space.update_attributes(params[:space])
        @micropost.save!
        format.html { redirect_to [@building], notice: 'Space was successfully updated.' }
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
