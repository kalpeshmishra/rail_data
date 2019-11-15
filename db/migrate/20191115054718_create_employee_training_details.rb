class CreateEmployeeTrainingDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_training_details do |t|
    	t.integer 		:employee_id
    	t.integer			:employee_category_id
    	t.date				:start_date
    	t.date				:end_date
    	t.string			:training_type
    	t.date				:next_due_date
    	t.string 			:certificate_no
    	t.string 			:grade_received
    	t.string 			:training_center
    	t.string 			:remark
      t.timestamps

    end
  end
end
