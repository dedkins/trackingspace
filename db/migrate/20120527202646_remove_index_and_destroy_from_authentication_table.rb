class RemoveIndexAndDestroyFromAuthenticationTable < ActiveRecord::Migration
  def up
    remove_column :authentications, :index
    remove_column :authentications, :destroy
  end

  def down
  end
end
