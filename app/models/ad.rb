# == Schema Information
#
# Table name: ads
#
#  id          :integer          not null, primary key
#  building_id :integer
#  user_id     :integer
#  slot        :string(255)
#  title       :string(255)
#  message     :text
#  type        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  space_id    :integer
#

class Ad < ActiveRecord::Base

	belongs_to :user
	belongs_to :building
	belongs_to :space

  	attr_accessible :building_id, :space_id, :message, :slot, :title, :type, :user_id
  	
end
