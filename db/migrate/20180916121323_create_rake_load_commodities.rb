class CreateRakeLoadCommodities < ActiveRecord::Migration[5.0]
  def change
    create_table :rake_load_commodities do |t|
    	t.integer :rake_load_id
    	t.integer :rake_commodity_id     
    	t.string :group_rake_commodity
    	t.string :commodity_name
    	t.string :commodity_full_name
      t.timestamps
    end
  end
end
