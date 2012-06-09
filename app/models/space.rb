class Space < ActiveRecord::Base
  belongs_to :building
  
  attr_accessible :rate, :sf, :suite
end
