class CreateMajorCommodities < ActiveRecord::Migration[5.0]
  def change
    create_table :major_commodities do |t|
      t.string :major_commodity
      t.string :name
      t.timestamps
    end
  end
end
