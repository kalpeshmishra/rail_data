class CreateCrackRakes < ActiveRecord::Migration[5.0]
  def change
    create_table :crack_rakes do |t|
    	t.string			:train_name
    	t.string 			:power_number
    	t.string 			:stock_type
    	t.string      :order_time
      t.date        :order_date
      t.string      :on_duty_time
      t.date        :on_duty_date
      t.string 			:pre_departure_detnention
      t.string 			:departure_station
      t.string			:departure_time
      t.date 				:departure_date
      t.string 			:dhg_arrival_time
      t.date  			:dhg_arrival_date
      t.string 			:tor_departure_dhg_arrival  #TOR- Train on run detention
      t.string 			:gimb_arrival_time
      t.date 				:gimb_arrival_date
      t.string 			:off_duty_time
      t.date 				:off_duty_date
      t.string 			:detention_on_to_off_duty
      t.string 			:tor_departure_gimb_arrival
      t.string 			:remarks
      t.timestamps
    end
  end
end
