class AddSpaceIdToAds < ActiveRecord::Migration
  def change
    add_column :ads, :space_id, :integer
  end
end
