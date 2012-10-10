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
#

class User < ActiveRecord::Base
  has_many :authentications
  has_many :microposts, :dependent => :destroy
  has_many :BuildingOrders
  has_many :user_relationships, :foreign_key => "follower_id", :dependent => :destroy
  has_many :following, :through => :user_relationships, :source => :followed
  has_many :reverse_user_relationships, :foreign_key => "followed_id", :class_name => "UserRelationship", :dependent => :destroy
  has_many :followers, :through => :reverse_user_relationships
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name
  # attr_accessible :title, :body

  def feed
    Micropost.from_users_followed_by(self)
  end

  def recent
    @recent_items = BuildingOrder.where("user_id = ?", id).limit(10).order('created_at desc')
  end

  def lease
    Lease.where("user_id = ?", id)
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

  #def password_required?
  #	(authentications.empty? || !password.blank?) && super
  #end

end
