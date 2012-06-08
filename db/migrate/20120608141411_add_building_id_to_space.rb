class AddBuildingIdToSpace < ActiveRecord::Migration
  def change
  	add_column :spaces, :building_id, :integer
  end
end
