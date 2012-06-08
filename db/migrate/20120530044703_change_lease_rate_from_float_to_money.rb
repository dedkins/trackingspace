class ChangeLeaseRateFromFloatToMoney < ActiveRecord::Migration
  def up
    change_column :leases, :current_rate, :money
  end

  def down
    change_column :leases, :current_rate, :float
  end
end
