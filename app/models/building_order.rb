class BuildingOrder < ActiveRecord::Base
  belongs_to :building, :dependent => :destroy
  belongs_to :user, :dependent => :destroy

  attr_accessible :building_id, :user_id

  default_scope :order => 'created_at DESC'

end
