# == Schema Information
#
# Table name: microposts
#
#  id          :integer          not null, primary key
#  content     :string(255)
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  building_id :integer
#  space_id    :integer
#  lease_id    :integer
#  address     :string(255)
#  suite       :string(255)
#  name        :string(255)
#  typeof      :string(255)
#

class Micropost < ActiveRecord::Base
  attr_accessible :content, :building_id, :space_id, :lease_id, :address, :name, :suite, :typeof, :postforuser

  belongs_to :user, :class_name => "User"
  belongs_to :postforuser, :class_name => "User"
  belongs_to :building
  belongs_to :space


  default_scope :order => 'microposts.created_at DESC'

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM user_relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
          user_id: user.id)
  end

  def self.from_buildings_followed_by(user)
    followed_user_ids = "SELECT building_id FROM building_relationships
                         WHERE user_id = :user_id"
    where("building_id IN (#{followed_user_ids})",user_id: user.id)
  end

end
