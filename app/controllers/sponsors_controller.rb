class SponsorsController < ApplicationController

	before_filter :authenticate_user!

	def sendsponsoremail
		@sponsoring = User.find(current_user.id)
		@exist = Sponsor.find_by_sponsoredby_id_and_email(@sponsoring.id,params[:email])
		@existother = Sponsor.find_by_email(params[:email])
		if @exist != nil and @exist.accepted != true
			respond_to do |format|
				flash[:alert] = "Wow. You must really like them...looks like you've already sent a request to #{params[:email]} - check your outstanding list!"
				format.html { redirect_to(:back) }
				format.js
			end
		elsif @exist != nil and @exist.accepted == true
			respond_to do |format|
				flash[:alert] = "Looks like they are already your client!"
				format.html { redirect_to(:back) }
				format.js
			end
		elsif @existother != nil and @existother.accepted == true
			respond_to do |format|
				flash[:alert] = "Looks like #{params[:email]} has already been sponsored!"
				format.html { redirect_to(:back) }
				format.js
			end
		else
			@sponsor = Sponsor.create!(:sponsoredby_id => @sponsoring.id,:email => params[:email])
			UserMailer.sponsor_email(@sponsor).deliver
			respond_to do |format|
				flash[:notice] = "Email has been sent to #{@sponsor.email}!"
				format.html { redirect_to(:back) }
				format.js
			end	
		end
	end

	def accept
		@sponsor = Sponsor.find(params[:id])
		@sponsored = User.find_by_email(@sponsor.email)
		if @sponsored != nil
			@sponsored_id = User.find(@sponsored.id)
			@already = Sponsor.find_by_sponsoredmember_id(@sponsored_id.id)
			if @already != nil
				flash[:alert] = "Looks like you are already sponsored!"
			else
				@sponsor.update_attributes(:sponsoredmember_id => @sponsored_id.id, :date_accepted => Time.now, :accepted => true)
				UserMailer.sponsor_accept(@sponsor).deliver
			end
		end
		respond_to do |format|
			format.html { redirect_to @user }
			format.js
		end
	end

	def destroy
		@sponsorid = Sponsor.find(params[:id]).delete
		redirect_to sponsored_path
	end

end