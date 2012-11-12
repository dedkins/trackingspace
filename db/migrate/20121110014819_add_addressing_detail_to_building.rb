class AddAddressingDetailToBuilding < ActiveRecord::Migration
  def change
    add_column :buildings, :street_number, :string
    add_column :buildings, :route, :string
    add_column :buildings, :locality, :string
    add_column :buildings, :administrative_area_level_1, :string
    add_column :buildings, :administrative_area_level_2, :string
    add_column :buildings, :postal_code, :string
    add_column :buildings, :country, :string
  end
end
