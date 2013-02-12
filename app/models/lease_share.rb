# == Schema Information
#
# Table name: lease_shares
#
#  id          :integer          not null, primary key
#  lease_id    :integer
#  shared_from :integer
#  shared_to   :integer
#  email       :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class LeaseShare < ActiveRecord::Base
  attr_accessible :lease_id, :space_id, :sharedfrom_id, :sharedto_id, :email

  belongs_to :sharedfrom, :class_name => "User"
  belongs_to :sharedto, :class_name => "User"
  belongs_to :space
  belongs_to :lease

end
