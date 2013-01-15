class AddingPropmgmtToMicropost < ActiveRecord::Migration
  def change
  	add_column :microposts, :propmgmt, :boolean
  end
end
