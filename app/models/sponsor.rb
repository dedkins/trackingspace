# == Schema Information
#
# Table name: sponsors
#
#  id               :integer          not null, primary key
#  sponsored_by     :integer
#  sponsored_member :integer
#  accepted         :boolean
#  date_accepted    :date
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Sponsor < ActiveRecord::Base
  attr_accessible :accepted, :date_accepted, :sponsored_by, :sponsored_member, :email

  belongs_to :sponsorships, :class_name => "User"
  belongs_to :sponsoring, :class_name => "User"


end
