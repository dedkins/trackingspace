class AddBrokerToUser < ActiveRecord::Migration
  def change
    add_column :users, :broker, :boolean
  end
end
