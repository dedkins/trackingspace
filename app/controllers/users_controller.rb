class UsersController < ApplicationController
  def index
    @title = "Users"
  	@users = User.all
  end

  def leases
    @user = User.find(current_user.id)
    @leases = @user.lease
    @total = @leases.all.size*@leases.all.current_rate
  end

  def show
  	@user = User.find(params[:id])
  	@micropost = Micropost.new if signed_in?
  	@feed_items = @user.feed
  end

  def edit
  end
end
