# == Schema Information
#
# Table name: leases
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  size              :integer
#  current_rate      :decimal(10, 2)
#  expiration        :date
#  space_id          :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  file              :string(255)
#  file_file_name    :string(255)
#  file_content_type :string(255)
#  file_file_size    :integer
#  file_updated_at   :datetime
#

class Lease < ActiveRecord::Base
  belongs_to :user
  has_many :users, :through => :lease_shares
  belongs_to :space
  has_many :lease_shares, :dependent => :destroy

  validates_attachment_content_type :file, :content_type => ['image/jpeg', 'image/png', 'image/gif','application/pdf']
  
  attr_accessible :current_rate, :expiration, :size, :space_id, :user_id, :file

  default_scope order('expiration ASC')


  #paperclip
  has_attached_file :file,
     :storage => :s3,
     :s3_credentials => "#{Rails.root}/config/s3.yml",
     :path => "#{Rails.root}/public/system/:attachment/:id/:style/:filename"

end


