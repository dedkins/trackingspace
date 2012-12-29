# == Schema Information
#
# Table name: buildings
#
#  id                          :integer          not null, primary key
#  latitude                    :float
#  longitude                   :float
#  address                     :string(255)
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  gmaps                       :boolean
#  user_id                     :integer
#  status                      :string(255)
#  size                        :decimal(, )
#  street_number               :string(255)
#  route                       :string(255)
#  locality                    :string(255)
#  administrative_area_level_1 :string(255)
#  administrative_area_level_2 :string(255)
#  postal_code                 :string(255)
#  country                     :string(255)
#  pretty_url                  :string(255)
#  slug                        :string(255)
#  videourl                    :string(255)
#

require 'test_helper'

class BuildingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
