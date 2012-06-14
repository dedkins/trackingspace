class Building < ActiveRecord::Base
  has_many :spaces
  attr_accessible :address, :latitude, :longitude, :user_id

  acts_as_gmappable
  
  def gmaps4rails_address
  #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{self.address}, #{self.latitude}, #{self.longitude}" 
  end
  
end

