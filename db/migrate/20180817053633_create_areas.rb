class CreateAreas < ActiveRecord::Migration[5.0]
  def change
    create_table :areas do |t|
      t.integer :railway_zone_id
      t.integer :division_id
      t.string :area_code
      t.string :area_name
      t.timestamps
    end
  end
end
