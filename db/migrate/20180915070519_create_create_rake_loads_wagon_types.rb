class CreateCreateRakeLoadsWagonTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :create_rake_loads_wagon_types do |t|
      t.integer :rake_load_id
      t.integer :wagon_type_id
      t.timestamps
    end
  end
end
