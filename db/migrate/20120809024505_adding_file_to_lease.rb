class AddingFileToLease < ActiveRecord::Migration
  def up
  	add_attachment :leases, :file
  end

  def down
  	remove_attachment :leases, :file
  end
end
