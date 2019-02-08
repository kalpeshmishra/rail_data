class CreateRakeLoads < ActiveRecord::Migration[5.0]
  def change
    create_table :rake_loads do |t|
       t.integer    :load_unload_id  # from station
       t.integer    :station_id      # to station
       t.date       :forecast_date
       t.string     :rake_received
       t.integer    :loaded_unit
       t.integer    :total_unit
       t.integer    :wagon_type_id
       t.integer    :major_commodity_id
       t.float      :gross_tons
       t.float      :net_tons
       t.float      :rake_count
       t.string     :stack         # single or double only enable for container wagon type
       t.string     :arrival_time
       t.date        :arrival_date
       t.string     :placement_time
       t.date     :placement_date
       t.string       :release_time
       t.date       :release_date
       t.string     :powerarrival_time
       t.date     :powerarrival_date
       t.string     :removal_time
       t.date     :removal_date
       t.string     :departure_time
       t.date     :departure_date
       t.integer    :power_no
       t.string     :bpc_type   # Static dropdown
       t.string     :bpc_station
       t.date       :bpc_date
       t.integer    :tue_first_row
       t.integer    :tue_second_row
       t.string     :commodity_type  # Two type  only Imported/Domesctic
       t.string     :odr_type        # static dropdown a,b,c,d,e
       t.string     :odr_time
       t.date     :odr_date        # disable for container rake type
       t.string     :consignor     #party loading or sending goods
       t.string     :consignee     # party unloading or receiving goods 
       t.string     :actual_interchange   # static dropdown having GER,VGDC,PNU BLDI,MALB,DHG
       t.string     :ic_time
       t.date     :ic_date
       t.string     :short_interchange    #static dropdown having GER,VGDC,PNU BLDI,MALB,DHG       
       t.float      :short_km          # shortest route kilometer
       t.string     :rake_loading_id   # autogenerate 
       t.string     :back_loading   # Backloading rake id
       t.string     :remark
       t.string     :rakeform_otherform     # R for rake_form & O for other_form
       t.string     :detention_arrival_placement
       t.string     :detention_placement_release
       t.string     :detention_release_removal
       t.string     :detention_removal_departure
       t.string     :detention_release_powerarrival #do not want negative value i.e if power arrival is before release the detention should be nil/na
       t.string     :detention_powerarrival_departure #detn rake_departure to powerarrival but if powerarrival is before release to departure
       
       t.timestamps

    end
  end
end
