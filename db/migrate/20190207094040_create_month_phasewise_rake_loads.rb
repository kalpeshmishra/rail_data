class CreateMonthPhasewiseRakeLoads < ActiveRecord::Migration[5.0]
  def change
    create_table :month_phasewise_rake_loads do |t|
    	t.string     :load_month 
    	t.integer    :load_unload_id  # from station
    	t.string 		 :commodity_type
    	t.float      :rake_count
    	t.integer    :loaded_unit
    	t.string     :detention_arrival_placement
      t.string     :detention_placement_release
      t.string     :detention_release_departure
      t.string     :detention_release_removal
      t.string     :detention_removal_departure
      t.string     :detention_release_powerarrival
      t.string     :detention_powerarrival_departure
      t.string 		 :extra
      t.string 		 :extra_one
      t.timestamps
    end
  end
end
