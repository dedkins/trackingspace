# == Schema Information
#
# Table name: subscriptions
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  plan_id           :integer
#  plan_name         :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  stripe_card_token :string(255)
#  email             :string(255)
#

require 'spec_helper'

describe Subscription do
  pending "add some examples to (or delete) #{__FILE__}"
end
