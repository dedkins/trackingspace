class Building < ActiveRecord::Base
  has_many :spaces
  has_many :microposts, :dependent => :destroy
  attr_accessible :address, :latitude, :longitude, :user_id

  validates :latitude, :presence => true
  validates :longitude, :presence => true

  default_scope :order => 'created_at DESC'

  acts_as_gmappable
  
  def gmaps4rails_address
  #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{self.address}, #{self.latitude}, #{self.longitude}" 
  end

  def feed
    Micropost.where("building_id = ?", id)
  end
  
end

