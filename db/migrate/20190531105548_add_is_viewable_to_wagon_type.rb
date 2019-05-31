class AddIsViewableToWagonType < ActiveRecord::Migration[5.0]
  def change
    add_column :wagon_types, :is_viewable, :boolean
  end
end
