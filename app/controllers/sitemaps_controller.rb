class SitemapsController < ApplicationController
   def index
   	@buildings = Building.all
      respond_to do |format|
        format.xml
      end
  	end
 end