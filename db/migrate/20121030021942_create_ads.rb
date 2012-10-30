class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.integer :building_id
      t.integer :user_id
      t.string :slot
      t.string :title
      t.text :message
      t.string :type

      t.timestamps
    end
  end
end
