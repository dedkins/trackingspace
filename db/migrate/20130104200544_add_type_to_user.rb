class AddTypeToUser < ActiveRecord::Migration
  def change
    add_column :users, :access, :string
  end
end
