class AddGmapsToBuildingModel < ActiveRecord::Migration
  def change
    add_column :buildings, :gmaps, :boolean
  end
end
