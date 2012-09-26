class BuildingOrder < ActiveRecord::Base
  belongs_to :building
  belongs_to :user

  attr_accessible :building_id, :user_id

  default_scope :order => 'created_at DESC'

end
