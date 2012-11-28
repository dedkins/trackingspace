class AddVideourlToBuilding < ActiveRecord::Migration
  def change
    add_column :buildings, :videourl, :string
  end
end
