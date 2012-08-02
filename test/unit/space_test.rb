# == Schema Information
#
# Table name: spaces
#
#  id          :integer          not null, primary key
#  sf          :integer
#  monthly     :decimal(10, 2)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  building_id :integer
#  suite       :string(255)
#  user_id     :integer
#  company     :string(255)
#  status      :string(255)
#  _3dplanurl  :string(255)
#

require 'test_helper'

class SpaceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
