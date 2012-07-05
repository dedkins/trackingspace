class Micropost < ActiveRecord::Base
  attr_accessible :content, :building_id, :space_id, :lease_id, :address, :name, :suite, :typeof

  belongs_to :user
  belongs_to :building

  default_scope :order => 'microposts.created_at DESC'
end
