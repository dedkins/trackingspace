class Lease < ActiveRecord::Base
  has_many :users
  belongs_to :space
  
  attr_accessible :current_rate, :expiration, :size, :space_id, :user_id
end
