class UsersController < ApplicationController
  def index
  end

  def show
  	@user = User.find(params[:id])
  	@micropost = Micropost.new if signed_in?
  end


  def edit
  end
end
