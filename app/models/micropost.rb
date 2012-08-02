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
  attr_accessible :content, :building_id, :space_id, :lease_id, :address, :name, :suite, :typeof

  belongs_to :user
  belongs_to :building
  belongs_to :space

  default_scope :order => 'microposts.created_at DESC'
end
