class Space < ActiveRecord::Base
  belongs_to :building
  
  attr_accessible :monthly, :sf, :suite
end
