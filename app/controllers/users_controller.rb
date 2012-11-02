class UsersController < ApplicationController
  autocomplete :user, :name, :full => true

  def index
    @title = "Users"
  	@users = User.all
  end

  def leases
    @title = 'My Leases'
    @user = User.find(current_user.id)
    @leases = @user.leases

    respond_to do |format|               
      format.js
    end 
  end

  def show
  	@user = User.find(params[:id])
  	@micropost = Micropost.new if signed_in?
  	@feed_items = @user.self_feed
    @authentications = Authentication.find_by_user_id(@user.id)
    @building_ads = @user.building_ads
    @space_ads = @user.space_ads  
    @leases = @user.leases if signed_in?            
    
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
    @user = current_user
    @authentications = Authentication.find_by_user_id(@user.id)
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
    @title = 'Following'
    @user = User.find(params[:id])
    @users = @user.following

    respond_to do |format|               
      format.js
    end 
  end

  def followers
    @title = 'Followers'
    @user = User.find(params[:id])
    @users = @user.followers
    
    respond_to do |format|               
      format.js
    end 
  end

  def trackingbuildings
    @title = 'Buildings Being Tracked'
    @user = User.find(params[:id])
    @buildings = @user.building_relationships   

    respond_to do |format|               
      format.js
    end   
  end

  def buildingads
    @title = 'Buildings Promoted'
    @user = User.find(params[:id])
    @buildings = @user.building_ads

    respond_to do |format|
      format.js
    end
  end

  def spaceads
    @title = 'Spaces Promoted'
    @user = User.find(params[:id])
    @spaces = @user.space_ads

    respond_to do |format|
      format.js
    end
  end

end
