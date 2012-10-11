class BuildingRelationship < ActiveRecord::Base
  attr_accessible :building_id, :user_id

  belongs_to :building
  belongs_to :user
  
end
