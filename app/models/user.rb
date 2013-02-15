# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  rpx_indentifier        :string(255)
#  name                   :string(255)
#  username               :string(255)
#  upgrade                :string(255)
#  description            :text
#  phone                  :string(255)
#  website                :string(255)
#  access                 :string(255)
#  latitude               :float
#  longitude              :float
#  license                :string(255)
#  broker                 :boolean
#

class User < ActiveRecord::Base
  has_many :authentications, :dependent => :destroy
  has_many :microposts, :class_name => "Micropost", :foreign_key => :user_id, :dependent => :destroy
  has_many :postforusers, :class_name => "Micropost", :foreign_key => :postforuser_id, :dependent => :destroy
  has_many :building_orders, :dependent => :destroy
  has_many :user_relationships, :foreign_key => "follower_id", :dependent => :destroy
  has_many :following, :through => :user_relationships, :source => :followed, :dependent => :destroy
  has_many :reverse_user_relationships, :foreign_key => "followed_id", :class_name => "UserRelationship", :dependent => :destroy
  has_many :followers, :through => :reverse_user_relationships, :dependent => :destroy
  has_many :building_relationships, :dependent => :destroy
  has_one  :subscription
  has_many :ads, :dependent => :destroy
  has_many :sponsors, :foreign_key => "sponsoredby_id", :dependent => :destroy
  has_many :sponsoredby, :through => :sponsors, :source => :sponsoredby, :dependent => :destroy
  has_many :reverse_sponsors, :foreign_key => "sponsoredmember_id", :class_name => "Sponsor", :dependent => :destroy
  has_many :sponsoredmember, :through => :reverse_sponsors, :dependent => :destroy
  has_many :lease_shares, :foreign_key => "sharedfrom_id", :dependent => :destroy
  has_many :sharedfrom, :through => :lease_shares, :source => :sharedfrom, :dependent => :destroy
  has_many :reverse_lease_shares, :foreign_key => "sharedto_id", :class_name => "LeaseShare", :dependent => :destroy
  has_many :sharedto, :through => :reverse_lease_shares, :dependent => :destroy
  has_many :leases
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :geocity, :geostate, :geocountry, :geozip, :license, :email, :password, :password_confirmation, :remember_me, :name, :upgrade, :phone, :website, :description, :latitude, :longitude
  # attr_accessible :title, :body

  geocoded_by :current_sign_in_ip
    after_validation :geocode

  reverse_geocoded_by :latitude, :longitude do |obj,results|
    if geo = results.first
      obj.geocity    = geo.city
      obj.geozip     = geo.postal_code
      obj.geostate   = geo.state_code
      obj.geocountry = geo.country
    end
  end
  after_validation :reverse_geocode

  #acts_as_gmappable :process_geocoding => false
  
  def gmaps4rails_address
  #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{self.latitude}, #{self.longitude}" 
  end

  def gmaps4rails_title
    "#{self.name} - #{self.geocity}"
  end

  def feed
    Micropost.from_users_followed_by(self)
  end

  def self_feed
    Micropost.where("user_id = ? OR postforuser_id = ?", self, self)
  end

  def building_following?(building)
    building_relationships.find_by_building_id(building)
  end

  def building_feed
    Micropost.from_buildings_followed_by(self)
  end

  def recent
    @recent_items = BuildingOrder.where("user_id = ?", id).limit(10).order('created_at desc')
  end

  def leases
    @shared = LeaseShare.where("sharedto_id = ? OR email = ?", id, email).all
    unless @shared.empty?
      (Lease.where("user_id = ?", id).all + Lease.find(@shared.map(&:lease_id).uniq)).uniq
    else
      Lease.where("user_id = ?", id)
    end
  end

  def apply_omniauth(omniauth)
  	authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  def following?(followed)
    user_relationships.find_by_followed_id(followed)
  end

  def follow!(followed)
    user_relationships.create!(:followed_id => followed.id)
  end

  def unfollow!(followed)
    user_relationships.find_by_followed_id(followed).destroy
  end

  def sponsoring?(sponsoring)
    sponsors.find_by_sponsoredby_id(sponsoring)
  end

  def sponsoravail
    if upgrade == nil and Sponsor.where('sponsoredby_id = ?', id).count < 3
      true
    elsif upgrade == 'Upgrade5' and Sponsor.where('sponsoredby_id = ?', id).count < 6
      true
    elsif upgrade == 'Upgrade30' and Sponsor.where('sponsoredby_id = ?', id).count < 31
      true
    elsif upgrade == 'Upgrade100'
      true
    else 
      false
    end
  end

  def sponsorleft
    if upgrade == nil or upgrade == ''
      2 - (Sponsor.where('sponsoredby_id = ?', id).count)
    elsif upgrade == 'Upgrade5'
      5 - (Sponsor.where('sponsoredby_id = ?', id).count)
    elsif upgrade == 'Upgrade30'
      30 - (Sponsor.where('sponsoredby_id = ?', id).count)
    end
  end

  scope :new_users, lambda {
    {
      :conditions => ["created_at >= ?", Time.now.prev_month]
    }
  }

  def building_ads
    Ad.where("user_id = ? and building_id IS NOT NULL", id)
  end

  def space_ads
    Ad.where("user_id = ? and space_id IS NOT NULL", id)
  end
  #def password_required?
  #	(authentications.empty? || !password.blank?) && super
  #end

end
