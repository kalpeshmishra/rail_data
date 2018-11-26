class CreateWagonTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :wagon_types do |t|
    	t.string :group_rake_type
	    t.string :rake_type
	    t.string :stock_type_code
	    t.string :wagon_type_code
	    t.string :wagon_type_desc
	    t.string :wagon_details_brake_type
	    t.string :wagon_details_covered_open
	    t.string :wagon_details_min_max_tare
	    t.string :allowed_cmdt
	    t.integer :load_class_wagon
	    t.integer :load_class_train
      t.timestamps
    end
  end
end
