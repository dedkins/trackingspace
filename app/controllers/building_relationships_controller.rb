class BuildingRelationshipsController < ApplicationController

	def create
		@user = current_user
		@building = Building.find(params[:building_relationship][:building_id])
		current_user.building_relationships.create!(:building_id => @building.id)
		respond_to do |format|
			format.html { redirect_to @building }
			format.js
		end
	end

	def destroy
		@user = current_user
		@br = BuildingRelationship.find(params[:id])
		if params[:id].present?
			@building = Building.find(@br.building_id)
		end
		if params[:slug].present?
			@building = Building.find_by_slug(params[:slug])
		end
		current_user.building_relationships.find(@br).destroy
		respond_to do |format|
			format.html { redirect_to building_path(@building.slug) }
			format.js
		end
	end

end