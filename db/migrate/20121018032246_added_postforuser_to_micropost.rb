class AddedPostforuserToMicropost < ActiveRecord::Migration
  def change
  	add_column :microposts, :postforuser, :integer
  end

end
