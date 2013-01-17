class AddLicenseToUsers < ActiveRecord::Migration
  def change
    add_column :users, :license, :string
  end
end
