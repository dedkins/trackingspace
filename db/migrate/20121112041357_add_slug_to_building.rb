class AddSlugToBuilding < ActiveRecord::Migration
  def change
    add_column :buildings, :slug, :string
    add_index :buildings, :slug
  end
end
