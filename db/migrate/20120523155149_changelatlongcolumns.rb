class Changelatlongcolumns < ActiveRecord::Migration
  def up
    rename_column :buildings, :lat, :latitude
    rename_column :buildings, :long, :longitude
    add_column :buildings, :gmaps, :boolean 
  end

  def down
  end
end
