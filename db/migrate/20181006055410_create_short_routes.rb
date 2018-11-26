class CreateShortRoutes < ActiveRecord::Migration[5.0]
  def change
    create_table :short_routes do |t|
      t.string  :from_station
      t.string  :to_station
      t.float   :short_route_distance
      t.string  :short_interchange_point
      t.float   :other_route_distance
      t.string  :other_interchange_point
      t.string  :description
      t.timestamps
    end
  end
end
