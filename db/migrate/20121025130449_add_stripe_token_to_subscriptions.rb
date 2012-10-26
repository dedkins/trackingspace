class AddStripeTokenToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :stripe_card_token, :string
  end
end
