class Add3DfloorplanToSpaces < ActiveRecord::Migration
  def up
  	add_column :spaces, :_3dplanurl, :string
  end

  def down
  end
end
