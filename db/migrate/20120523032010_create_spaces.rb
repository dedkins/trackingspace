class CreateSpaces < ActiveRecord::Migration
  def change
    create_table :spaces do |t|
      t.integer :sf
      t.integer :rate

      t.timestamps
    end
  end
end
