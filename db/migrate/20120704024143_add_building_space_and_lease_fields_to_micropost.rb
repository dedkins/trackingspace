class AddBuildingSpaceAndLeaseFieldsToMicropost < ActiveRecord::Migration
  def change
  	add_column :microposts, :building_id, :integer
  	add_column :microposts, :space_id, :integer
  	add_column :microposts, :lease_id, :integer
  end
end
