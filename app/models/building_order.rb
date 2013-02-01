# == Schema Information
#
# Table name: building_orders
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  building_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class BuildingOrder < ActiveRecord::Base
  belongs_to :building
  belongs_to :user

  attr_accessible :building_id, :user_id

  default_scope :order => 'created_at DESC'

end
