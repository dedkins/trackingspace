class Space < ActiveRecord::Base
  belongs_to :building
  has_many :leases
  has_many :microposts
  
  attr_accessible :monthly, :sf, :suite

  default_scope :order => 'spaces.suite ASC'
end
