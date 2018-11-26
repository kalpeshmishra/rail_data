class CreateCreateRakeLoadsRakeCommodities < ActiveRecord::Migration[5.0]
  def change
    create_table :create_rake_loads_rake_commodities do |t|
      t.integer :rake_load_id
      t.integer :rake_commodity_id
      t.integer :rake_unit
      t.float :commodity_rake_count
      t.timestamps
    end
  end
end
