class AddDescriptionToSpace < ActiveRecord::Migration
  def change
    add_column :spaces, :description, :text
  end
end
