# == Schema Information
#
# Table name: lease_shares
#
#  id          :integer          not null, primary key
#  lease_id    :integer
#  shared_from :integer
#  shared_to   :integer
#  email       :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe LeaseShare do
  pending "add some examples to (or delete) #{__FILE__}"
end
