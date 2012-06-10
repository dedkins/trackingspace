class ChangeRateToMonthlyAndTypeOfDecimal < ActiveRecord::Migration
  def up
  	change_column :spaces, :rate, :decimal, :precision => 10, :scale => 2
  	rename_column :spaces, :rate, :monthly
  end

  def down
  end
end
