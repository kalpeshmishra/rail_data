class CreateStationUnderTiUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :station_under_ti_users do |t|
    	t.integer :user_id     
    	t.integer :station_id
      t.timestamps
    end
  end
end
