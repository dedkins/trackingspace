class RemoveCreateColumnFromAuthenticationModel < ActiveRecord::Migration
  def up
    remove_column :authentications, :create
  end

  def down
  end
end
