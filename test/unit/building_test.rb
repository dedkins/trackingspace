# == Schema Information
#
# Table name: buildings
#
#  id         :integer          not null, primary key
#  latitude   :float
#  longitude  :float
#  address    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  gmaps      :boolean
#  user_id    :integer
#  status     :string(255)
#  size       :decimal(, )
#

require 'test_helper'

class BuildingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
