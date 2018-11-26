class CreateLoadUnloads < ActiveRecord::Migration[5.0]
  def change
    create_table :load_unloads do |t|
      t.string :station_name
      t.string :serving_station
      t.integer :station_id
      t.integer :area_id
      t.integer :division_id
      t.string :status
      t.string :desc
      t.timestamps
      t.timestamps
    end
  end
end
