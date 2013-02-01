class CreateSponsors < ActiveRecord::Migration
  def change
    create_table :sponsors do |t|
      t.integer :sponsored_by
      t.integer :sponsored_member
      t.boolean :accepted
      t.date :date_accepted
      t.string	:email

      t.timestamps
    end
  end
end
