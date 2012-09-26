class CreateBuildingOrders < ActiveRecord::Migration
  def change
    create_table :building_orders do |t|
      t.integer :user_id
      t.integer :building_id

      t.timestamps
    end
  end
end
