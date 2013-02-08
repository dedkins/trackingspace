# == Schema Information
#
# Table name: subscriptions
#
#  id                    :integer          not null, primary key
#  user_id               :integer
#  plan_id               :integer
#  plan_name             :string(255)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  stripe_card_token     :string(255)
#  email                 :string(255)
#  stripe_customer_token :string(255)
#

class Subscription < ActiveRecord::Base

  attr_accessible :stripe_card_token, :plan_id, :plan_name, :email, :user_id

  def save_with_payment
    if valid?
      customer = Stripe::Customer.create(description: email,
        plan: plan_id, card: stripe_card_token)
      self.stripe_customer_token = customer.id
      save!
    end
  end

end
