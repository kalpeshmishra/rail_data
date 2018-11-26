class CreateRakeUnloads < ActiveRecord::Migration[5.0]
  def change
    create_table :rake_unloads do |t|
      t.string     :takenover_point     # Dropdown option GER, SIOB, VGDC,MALB,DHG  -for FORM-GETS-AECS (POWERHOUSE)
      t.string     :takenover_time                 # for FORM-GETS-AECS (POWERHOUSE)
      t.date       :takenover_date                 # for FORM-GETS-AECS (POWERHOUSE)
      t.string     :train_on_run_hours      # In hours(Takenovertime-Placementtime)   -for FORM-GETS-AECS (POWERHOUSE)
      t.string     :empty_destination
      t.string     :handedover_point
      t.string     :handedover_time
      t.date       :handedover_date
      t.string     :detention_ger_to_ger_tor  # In hours ger(point)tor(train-on-run) enable only if takenove_point & handedover_point is ger

      t.integer    :station_id   # from station
      t.integer    :load_unload_id     # to station
      t.integer    :loaded_unit
      t.integer    :total_unit
      t.integer    :wagon_type_id
      t.string     :stock_description
      t.float      :rake_count
      t.integer    :major_commodity_id
      t.string     :stack         # single or double only enable for container wagon type
      t.integer    :tue_first_row
      t.integer    :tue_second_row
      t.string     :arrival_time
      t.date       :arrival_date
      t.string     :placement_time
      t.date       :placement_date
      t.string     :release_time
      t.date       :release_date
      t.string     :bpc_type   # Static dropdown
      t.string     :bpc_station
      t.date       :bpc_date
      t.string     :bpc_validity
      t.string     :empty_rake_release_id  # Auto generate from system
      t.string     :removal_time
      t.date       :removal_date
      t.string     :commodity_breakup
      t.string     :commodity_type       # Imported/Domestic
      t.string     :collary
      t.string     :consignor
      t.string     :consignee
      t.string     :status     
      t.integer    :power_no
      t.string     :powerarrival_time
      t.date       :powerarrival_date
      t.string     :stable_time
      t.date       :stable_date
      t.string     :departure_time
      t.date       :departure_date
      t.string     :remarks
      t.string     :form_status      # RAKE, OTHER, GETS(POWERHOUSE),AECS (POWERHOUSE)
      t.string     :detention_arrival_placement
      t.string     :detention_placement_release
      t.string     :detention_release_removal
      t.string     :detention_removal_departure
      t.string     :detention_for_power
      t.string     :powerarrival_train_departure   # detention power arrival to train departure
      t.string     :detention_stable_departure
      t.string     :detention_in_out
      
      t.timestamps
    end
  end
end
