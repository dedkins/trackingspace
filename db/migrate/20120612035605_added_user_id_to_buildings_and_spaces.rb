class AddedUserIdToBuildingsAndSpaces < ActiveRecord::Migration
  def up
  	add_column :buildings, :user_id, :integer
  	add_column :spaces, :user_id, :integer
  end

  def down
  end
end
