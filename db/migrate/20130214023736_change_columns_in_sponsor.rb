class ChangeColumnsInSponsor < ActiveRecord::Migration
  def change
    rename_column :sponsors, :sponsored_by, :sponsoredby_id
    rename_column :sponsors, :sponsored_member, :sponsoredmember_id
  end
end
