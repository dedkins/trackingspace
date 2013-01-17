# == Schema Information
#
# Table name: microposts
#
#  id             :integer          not null, primary key
#  content        :string(255)
#  user_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  building_id    :integer
#  space_id       :integer
#  lease_id       :integer
#  address        :string(255)
#  suite          :string(255)
#  name           :string(255)
#  typeof         :string(255)
#  postforuser_id :integer
#  propmgmt       :boolean
#

require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
