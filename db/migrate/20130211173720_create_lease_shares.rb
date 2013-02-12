class CreateLeaseShares < ActiveRecord::Migration
  def change
    create_table :lease_shares do |t|
      t.integer :lease_id
      t.integer	:space_id
      t.integer :sharedfrom_id
      t.integer :sharedto_id
      t.string	:email

      t.timestamps
    end
  end
end
