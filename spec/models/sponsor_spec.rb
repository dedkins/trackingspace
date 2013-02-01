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

require 'spec_helper'

describe Sponsor do
  pending "add some examples to (or delete) #{__FILE__}"
end
