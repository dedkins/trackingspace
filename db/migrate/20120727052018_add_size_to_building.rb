class AddSizeToBuilding < ActiveRecord::Migration
  def change
  	add_column :buildings, :size, :numeric
  end
end
