class AddAddressSuiteAndNameToMicroposts < ActiveRecord::Migration
  def change
  	add_column :microposts, :address, :string
  	add_column :microposts, :suite, :string
  	add_column :microposts, :name, :string
  end
end
