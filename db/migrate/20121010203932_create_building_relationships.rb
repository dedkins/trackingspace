class CreateBuildingRelationships < ActiveRecord::Migration
  def change
    create_table :building_relationships do |t|
      t.integer :user_id
      t.integer :building_id

      t.timestamps
    end

    add_index :building_relationships, :user_id
    add_index :building_relationships, :building_id

  end
end
