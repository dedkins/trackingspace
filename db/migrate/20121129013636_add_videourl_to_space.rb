class AddVideourlToSpace < ActiveRecord::Migration
  def change
    add_column :spaces, :videourl, :string
  end
end
