class AddNumberFieldToSpace < ActiveRecord::Migration
  def change
  	add_column :spaces, :suite, :string
  end
end
