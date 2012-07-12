class AddCompanyToSpaces < ActiveRecord::Migration
  def change
  	add_column :spaces, :company, :string
  end
end
