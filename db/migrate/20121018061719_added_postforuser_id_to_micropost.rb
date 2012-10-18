class AddedPostforuserIdToMicropost < ActiveRecord::Migration
  def change
  	add_column :microposts, :postforuser_id, :integer
  end
end
