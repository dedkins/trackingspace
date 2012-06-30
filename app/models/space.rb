class Space < ActiveRecord::Base
  belongs_to :building
  has_many :leases
  
  attr_accessible :monthly, :sf, :suite
end
