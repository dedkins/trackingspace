class UsersController < ApplicationController
  def index
  end

  def show
  	@user = User.find(params[:id])
  	@micropost = Micropost.new if signed_in?
  	@feed_items = current_user.feed
  end

  def edit
  end
end
