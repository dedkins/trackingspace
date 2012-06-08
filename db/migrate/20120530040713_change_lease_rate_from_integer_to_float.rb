class ChangeLeaseRateFromIntegerToFloat < ActiveRecord::Migration
  def up
    change_column :leases, :current_rate, :float
  end

  def down
    change_column :leases, :current_rate, :integer
  end
end
