class CreateEmployeeAwardDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_award_details do |t|
    	t.integer   :employee_id
    	t.string 		:award_category
    	t.date  		:award_date
    	t.text  		:reason
      t.timestamps
    end
  end
end
