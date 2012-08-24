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

  validates_attachment_content_type :file, :content_type => ['image/jpeg', 'image/png', 'image/gif','application/pdf']
  
  attr_accessible :current_rate, :expiration, :size, :space_id, :user_id, :file

  #paperclip
  has_attached_file :file,
     :storage => :s3,
     :s3_credentials => "#{Rails.root}/config/s3.yml",
     :s3_permissions => :private,
     :path => "#{Rails.root}/public/system/:attachment/:id/:style/:filename"

end


