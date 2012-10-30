class AdsController < ApplicationController

  def new
    @ad = Ad.new
  	@title = 'New Ad For'
  	@user = User.find(current_user.id)
  	@slot = params[:s]
  	@building = Building.find(params[:id])
  end

  def create
  	@ad = Ad.create(params[:ad])
  	@back_to = params[:back_to]

  	if @ad.save!
  		redirect_to @back_to
  	end
  end

  def edit
    @title = 'Editing'
    @ad = Ad.find(params[:id])
  end

  def update
    @ad = Ad.find(params[:id])

    if @ad.update_attributes(params[:ad])
      redirect_to building_path(@ad.building_id)
    end
  end
end
