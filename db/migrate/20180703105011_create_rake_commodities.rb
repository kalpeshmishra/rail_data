class CreateRakeCommodities < ActiveRecord::Migration[5.0]
  def change
    create_table :rake_commodities do |t|
      t.integer :major_commodity_id
    	t.string :group_rake_commodity
	    t.string :rake_commodity_code
	    t.string :rake_commodity_name
      t.timestamps
    end
  end
end
