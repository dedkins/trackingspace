class AddTypeToMicroposts < ActiveRecord::Migration
  def change
  	add_column :microposts, :typeof, :string
  end
end
