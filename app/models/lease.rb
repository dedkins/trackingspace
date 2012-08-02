# == Schema Information
#
# Table name: leases
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  size         :integer
#  current_rate :decimal(10, 2)
#  expiration   :date
#  space_id     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Lease < ActiveRecord::Base
  has_many :users
  belongs_to :space
  
  attr_accessible :current_rate, :expiration, :size, :space_id, :user_id
end
