class AddIncomingPowerToRakeUnloads < ActiveRecord::Migration[5.0]
  def change
    add_column :rake_unloads, :incoming_power, :integer
  end
end
