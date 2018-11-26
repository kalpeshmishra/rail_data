class CreateIcDivisions < ActiveRecord::Migration[5.0]
  def change
    create_table :ic_divisions do |t|
      t.integer :railway_zone_id    # from zone
      t.integer :division_id        # from division
      t.string  :from_section
      t.string  :ic_code            # Incerchange point code
      t.string  :ic_name            # Interchange point name
      t.string  :to_section
      t.string :to_division        # To division
      t.string :to_zone    # To zone 
      t.string  :ic_by              # Interchange by arrival or departure
      t.string  :interchange_type   # ZONAL OR DIVISIONAL
      t.timestamps
    end
  end
end
