class CreateMonthRakeLoads < ActiveRecord::Migration[5.0]
  def change
    create_table :month_rake_loads do |t|
    	t.string     :load_month 
    	t.integer    :load_unload_id  # from station
    	t.integer    :station_id      # to station
    	t.integer    :loaded_unit
      t.integer    :total_unit
      t.integer    :wagon_type_id
      t.integer    :major_commodity_id
      t.integer    :double_stack 
      t.float      :gross_tons
      t.float      :net_tons
      t.float      :rake_count
      t.integer    :tue_first_row
      t.integer    :tue_second_row
      t.string 		 :extra
      t.string 		 :extra_one
      t.string 		 :extra_two
      t.timestamps
    end
  end
end
