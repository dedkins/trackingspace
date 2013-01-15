# == Schema Information
#
# Table name: buildings
#
#  id                          :integer          not null, primary key
#  latitude                    :float
#  longitude                   :float
#  address                     :string(255)
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  gmaps                       :boolean
#  user_id                     :integer
#  status                      :string(255)
#  size                        :decimal(, )
#  street_number               :string(255)
#  route                       :string(255)
#  locality                    :string(255)
#  administrative_area_level_1 :string(255)
#  administrative_area_level_2 :string(255)
#  postal_code                 :string(255)
#  country                     :string(255)
#  pretty_url                  :string(255)
#  slug                        :string(255)
#  videourl                    :string(255)
#

class Building < ActiveRecord::Base
  has_many :spaces
  has_many :microposts, :dependent => :destroy
  attr_accessible :address, :videourl, :latitude, :longitude, :user_id,:slug,:size,:street_number,:route,:locality,:administrative_area_level_1,:administrative_area_level_2,:postal_code,:country,:manager
  has_many :buildingorders
  has_many :building_relationships
  has_many :ads

  validates :latitude, :presence => true
  validates :longitude, :presence => true

  default_scope :order => 'created_at DESC'

  acts_as_gmappable

  extend FriendlyId
  friendly_id :slug
  
  def gmaps4rails_address
  #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{self.address}, #{self.latitude}, #{self.longitude}" 
  end

  def gmaps4rails_title
      "#{self.address}"
    end

  def feed
    Micropost.where("building_id = ?", id)
  end

  scope :new_buildings, lambda {
    {
      :conditions => ["created_at >= ?", Time.now.prev_month]
    }
  }
  
end

