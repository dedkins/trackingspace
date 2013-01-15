class AddingManagementToBuilding < ActiveRecord::Migration
  def change
  	add_column :buildings, :manager, :integer
  end

end
