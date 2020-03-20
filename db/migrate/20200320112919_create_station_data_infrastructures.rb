class CreateStationDataInfrastructures < ActiveRecord::Migration[5.0]
  def change
    create_table :station_data_infrastructures do |t|

      t.timestamps
    end
  end
end
