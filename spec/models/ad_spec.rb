# == Schema Information
#
# Table name: ads
#
#  id          :integer          not null, primary key
#  building_id :integer
#  user_id     :integer
#  slot        :string(255)
#  title       :string(255)
#  message     :text
#  type        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Ad do
  pending "add some examples to (or delete) #{__FILE__}"
end
