class AddStatusToSpacesAndBuildings < ActiveRecord::Migration
  def change
  	add_column :spaces, :status, :string
  	add_column :buildings, :status, :string
  end
end
