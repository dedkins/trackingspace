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
		@building = Building.find(params[:building_id])
		current_user.building_relationships.find(@br.id).destroy
		respond_to do |format|
			format.html { redirect_to @building.id }
			format.js
		end
	end

end