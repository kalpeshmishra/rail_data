class CreateRakeUnloadsRakeCommodities < ActiveRecord::Migration[5.0]
  def change
    create_table :rake_unloads_rake_commodities do |t|
    	t.integer :rake_unload_id
      t.integer :rake_commodity_id
      t.integer :rake_unit
      t.float :commodity_rake_count
      t.float :net_tons
      t.float :freight
      t.timestamps
    end
  end
end
