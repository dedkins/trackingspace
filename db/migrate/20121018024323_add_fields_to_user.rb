class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :upgrade, :string
    add_column :users, :description, :text
    add_column :users, :phone, :string
    add_column :users, :website, :string
  end
end
