class AddColumnToRakeLoads < ActiveRecord::Migration[5.0]
  def change
    add_column :rake_loads, :freight, :float
    add_column :rake_loads, :extra, :string
  end
end
