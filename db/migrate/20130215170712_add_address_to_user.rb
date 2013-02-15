class AddAddressToUser < ActiveRecord::Migration
  def change
  	add_column :users, :geocity, :string
  	add_column :users, :geozip, :string
  	add_column :users, :geostate, :string
  	add_column :users, :geocountry, :string
  end
end
