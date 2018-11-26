class CreateRailwayZones < ActiveRecord::Migration[5.0]
  def change
    create_table :railway_zones do |t|
    	t.string :name
	    t.string :code
	    t.string :zone_headquarter
	    t.datetime :created_at, null: false
	    t.datetime :updated_at, null: false
      t.timestamps
    end
  end
end
