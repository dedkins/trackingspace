# == Schema Information
#
# Table name: sponsors
#
#  id               :integer          not null, primary key
#  sponsored_by     :integer
#  sponsored_member :integer
#  accepted         :boolean
#  date_accepted    :date
#  email            :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Sponsor < ActiveRecord::Base
  attr_accessible :accepted, :date_accepted, :sponsoredby_id, :sponsoredmember_id, :email

  belongs_to :sponsoredby, :class_name => "User"
  belongs_to :sponsoredmember, :class_name => "User"


end
