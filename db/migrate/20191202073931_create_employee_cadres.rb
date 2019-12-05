class CreateEmployeeCadres < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_cadres do |t|
      t.integer   :station_id      
    	t.integer   :employee_post_id      
    	t.integer 	:number_of_post
    	t.string 		:remark
      t.timestamps
    end
  end
end
