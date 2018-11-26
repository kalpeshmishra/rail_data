class CreateDivisions < ActiveRecord::Migration[5.0]
  def change
    create_table :divisions do |t|
    	t.string :name
    	t.string :code
    	t.string :zone_headquarter
    	t.string :desc
    	t.integer :railway_zone_id
      
      t.timestamps
    end
  end
end
