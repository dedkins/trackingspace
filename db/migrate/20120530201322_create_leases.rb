class CreateLeases < ActiveRecord::Migration
  def change
    create_table :leases do |t|
      t.integer :user_id
      t.integer :size
      t.decimal :current_rate
      t.date :expiration
      t.integer :space_id

      t.timestamps
    end
  end
end
