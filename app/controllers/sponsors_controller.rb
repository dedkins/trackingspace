class SponsorsController < ApplicationController

	before_filter :authenticate_user!

	def sendsponsoremail
		@sponsoring = User.find(current_user.id)
		Sponsor.create!(:sponsored_by => @sponsoring.id,:email => params[:email])
		@sponsor = Sponsor.where('sponsored_by = ?', @sponsoring.id).last
		UserMailer.sponsor_email(@sponsor).deliver
		respond_to do |format|
			format.html { redirect_to request.env["HTTP_REFERER"] }
			format.js
		end
	end

	def accept
		@sponsorid = Sponsor.find(params[:id])
		@sponsored = User.find_by_email(@sponsorid.email)
		if @sponsored != nil
			@sponsored_id = User.find(@sponsored.id)
			@already = Sponsor.find_by_sponsored_member(@sponsored_id.id)
			if @already != nil
				flash[:alert] = "Looks like you are already sponsored!"
			else
				@sponsorid.update_attributes(:sponsored_member => @sponsored_id.id, :date_accepted => Time.now, :accepted => true)
			end
		end
		respond_to do |format|
			format.html { redirect_to @user }
			format.js
		end
	end

end