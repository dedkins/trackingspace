class BuildingRelationshipsController < ApplicationController

	def create
		@building = Building.find(params[:building_relationship][:building_id])
		current_user.building_relationships.create!(:building_id => @building.id)
		respond_to do |format|
			format.html { redirect_to @building }
			format.js
		end
	end

	def destroy
		@building = BuildingRelationship.find(params[:id])
		@building_record = Building.find(@building.building_id)
		current_user.building_relationships.find(@building).destroy
		respond_to do |format|
			format.html { redirect_to @building_record }
			format.js
		end
	end

end