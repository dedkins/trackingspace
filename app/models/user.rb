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
  has_many :sponsors, :foreign_key => "sponsored_by", :dependent => :destroy
  has_many :reverse_sponsors, :foreign_key => "sponsored_member", :class_name => "Sponsor", :dependent => :destroy
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
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :name, :upgrade, :phone, :website, :description, :latitude, :longitude
  # attr_accessible :title, :body

  geocoded_by :last_sign_in_ip
    after_validation :geocode, :if => :current_sign_in_at_changed? 

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
    sponsors.find_by_sponsored_by(sponsoring)
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
