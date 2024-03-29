class LeasesController < ApplicationController

  require 'paperclip'
  require 'aws-sdk'

  before_filter :authenticate_user!

  # GET /leases
  # GET /leases.json
  def index
    @space = Space.find(params[:space_id])
    @leases = Lease.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @leases }
    end
  end

  # GET /leases/1
  # GET /leases/1.json
  def show
    @user = current_user
    @space = Space.find(params[:space_id])
    @lease = Lease.find(params[:id])
    @leaseshares = LeaseShare.where("lease_id = ?",@lease.id).all
    @leaseshare = LeaseShare.find_by_lease_id_and_sharedto_id(@lease.id,current_user.id)
    if @leaseshare != nil
      @auth = true
    elsif @lease.user_id == current_user.id
      @auth = true
    else 
      @auth = false
    end

    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lease }
    end
  end

  def leases
    @leases = Lease.find_all_by_user_id(current_user.id)
  end
  
  # GET /leases/new
  # GET /leases/new.json
  def new
    @user = current_user.id
    @space = Space.find(params[:space_id])
    @lease = Lease.new
  end

  # GET /leases/1/edit
  def edit
    @user = current_user.id
    @space = Space.find(params[:space_id])
    @lease = Lease.find(params[:id])
  end

  # POST /leases
  # POST /leases.json
  
  def create
    @user = current_user.id
    @space = Space.find(params[:space_id])
    @lease = Lease.new(params[:lease])
    respond_to do |format|
      if @lease.save
        format.html { redirect_to space_lease_path(@space,@lease), notice: 'Lease was successfully created.' }
        format.json { render json: @lease, status: :created, location: @lease }
      else
        format.html { render action: "new" }
        format.json { render json: @lease.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /leases/1
  # PUT /leases/1.json
  def update
    @user = current_user.id
    @space = Space.find(params[:space_id])
    @lease = Lease.find(params[:id])

    respond_to do |format|
      if @lease.update_attributes(params[:lease])
        format.html { redirect_to space_lease_path(@space,@lease), notice: 'Lease was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lease.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leases/1
  # DELETE /leases/1.json
  def destroy
    @lease = Lease.find(params[:id])
    @lease.destroy

    respond_to do |format|
      format.html { redirect_to leases_url }
      format.json { head :no_content }
    end
  end

  def download
    redirect_to @lease.file.expiring_url(10)
  end
  
end