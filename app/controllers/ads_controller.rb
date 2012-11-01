class AdsController < ApplicationController

  def new
    @ad = Ad.new
  	@title = 'New Ad For'
  	@user = User.find(current_user.id)
  	@slot = params[:s]
    if params[:bid]
  	 @building = Building.find(params[:bid])
    end
    if params[:sid]
      @space = Space.find(params[:sid])
      @sbuilding = Building.find(@space.building_id)
    end
  end

  def create
  	@ad = Ad.create(params[:ad])
  	@back_to = params[:back_to]

  	if @ad.save!
  		redirect_to @back_to
  	end
  end

  def edit
    @user = User.find(current_user.id)
    @title = 'Editing'
    @ad = Ad.find(params[:id])
    @slot = @ad.slot
  end

  def update
    @ad = Ad.find(params[:id])

    if @ad.update_attributes(params[:ad])
      if @ad.building_id
        redirect_to building_path(@ad.building_id)
      end
      if @ad.space_id
        redirect_to building_space_path(@ad.space.building_id,@ad.space_id)
      end
    end
  end

  def destroy
    @ad = Ad.find(params[:id])
    if @ad.building_id
      @building = Building.find(@ad.building_id)
    end
    if @ad.space_id
      @space = Space.find(@ad.space_id)
    end
    @ad.destroy

    respond_to do |format|
      if @building 
        format.html { redirect_to building_path(@building) }
      end
      if @space
        format.html { redirect_to building_space_path(@building,@space)}
      end
      format.json { head :no_content }
    end
  end
end
