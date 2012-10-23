# == Schema Information
#
# Table name: building_relationships
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  building_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class BuildingRelationship < ActiveRecord::Base
  attr_accessible :building_id, :user_id

  belongs_to :building
  belongs_to :user
  
end
