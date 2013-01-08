class UserMailer < ActionMailer::Base
  default :to => @followers.all.map(&:email),
          :from => 'dedkins@trackingspace.com'
         

  def new_building_post(building)
    @building = Building.find(building)
    @followers = BuildingRelationship.find_all_by_building_id(@building.id)
    mail(:to => @followers.all.map(%:email), :subject => 'Update for @building.address')
  end

end