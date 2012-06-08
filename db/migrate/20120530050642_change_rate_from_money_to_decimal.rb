class ChangeRateFromMoneyToDecimal < ActiveRecord::Migration
  def up
    change_column :leases, :current_rate, :decimal
  end

  def down
    change_column :leases, :current_rate, :money
  end
end
