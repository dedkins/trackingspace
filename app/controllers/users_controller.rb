class UsersController < ApplicationController
  autocomplete :user, :name, :full => true

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
  	@feed_items = @user.self_feed
  end

  def search
    if !params[:user_name].nil?
      @user = User.find_by_name(params[:user_name])
      if @user.id
          redirect_to user_path(@user.id)
        else
          people_main_path
      end
     end
  end

  def edit
  end

  def update
    @user = current_user

    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(:page => params[:page])
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page])
    render 'show_follow'
  end
end
