class CreateLoadInterchanges < ActiveRecord::Migration[5.0]
  def change
    create_table :load_interchanges do |t|
    	t.date       :interchange_date
    	t.string		 :interchange_type # Received or Handedover(EX or TO)
    	t.string		 :interchange_point
    	t.string 		 :interchange_point_type # Zonal, Divisional or Inter-Division
    	t.integer    :wagon_type_id
    	t.string		 :stock_details   # Loaded or empty (L/E)
    	t.float			 :rakes
    	t.integer 	 :units
    	t.integer 	 :extra
    	t.string 		 :extra_one
      t.timestamps
    end
  end
end
