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

require 'test_helper'

class LeaseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
