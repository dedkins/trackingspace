class LeaseSharesController < ApplicationController

	before_filter :authenticate_user!

	def new
		@leaseshare = LeaseShare.new
	end

	def create
		@lease = Lease.find(params[:lease])
		@space = Space.find(params[:space])
		@sharedwithExistingUser = User.find_by_email(params[:email])
		@exist = LeaseShare.find_by_sharedfrom_id_and_email(current_user.id,params[:email])
		if @sharedwithExistingUser != nil
			@shared = LeaseShare.create!(:lease_id => @lease.id, :space_id => @space.id, :sharedfrom_id => current_user.id, :sharedto_id => @sharedwithExistingUser.id)
			@sharedto = User.find(@shared.sharedto_id)
			UserMailer.leaseshare_email_existing(@shared).deliver
			respond_to do |format|
				flash[:notice] = "Lease has been shared with #{@sharedto.email}!"
				format.html { redirect_to(:back) }
			end	
		else 
			@shared = LeaseShare.create!(:lease_id => @lease.id, :space_id => @space.id, :sharedfrom_id => current_user.id,:email => params[:email])
			UserMailer.leaseshare_email(@shared).deliver
			respond_to do |format|
				flash[:notice] = "Lease will be shared once #{@shared.email} becomes a member!"
				format.html { redirect_to(:back) }
			end	
		end
	end

	def accept
		@leaseshare = LeaseShare.find(params[:id])
		@user = User.find_by_email(current_user.email)
		@leaseshare.update_attribute(:sharedto_id, @user.id)
		flash[:success] = "Profile updated"
      	redirect_to space_lease_path(@leaseshare.space_id,@leaseshare.lease_id)
	end

	def destroy
		@leaseshare = LeaseShare.find(params[:id])
		@lease = @leaseshare.lease_id
	    @leaseshare.destroy

	    respond_to do |format|
	      format.html { redirect_to(:back) }
	      format.json { head :no_content }
	    end
	  end

end