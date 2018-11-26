class CreateStations < ActiveRecord::Migration[5.0]
  def change
    create_table :stations do |t|
    	t.string :name
	    t.string :code
	    t.string :inward_outward
	    t.string :gaug
	    t.string :section
	    t.integer :area_id
	    t.string :phsg_flag
	    t.string :dpnd_flag
	    t.string :srvg_sttn
	    t.string :old_srvg_sttn
	    t.string :dfrd_flag
	    t.string :desc
	    t.string :status
	    t.integer :numeric_code
	    t.integer :division_id
	    t.integer :railway_zone_id
	    t.integer :state_id
      t.timestamps
    end
  end
end
