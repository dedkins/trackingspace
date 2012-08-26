class PagesController < ApplicationController

def home
	@newbuildings = Building.new_buildings
	@json = Building.new_buildings.to_gmaps4rails
end

end