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

require 'test_helper'

class LeaseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
