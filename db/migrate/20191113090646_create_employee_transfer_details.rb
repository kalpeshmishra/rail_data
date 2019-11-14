class CreateEmployeeTransferDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_transfer_details do |t|
    	t.integer 		:employee_id
    	t.integer			:station_id
    	t.string			:transfer_type
    	t.date				:resume_date
    	t.date				:relieve_date
    	t.date				:transfer_date
    	t.string 			:letter_number
    	t.string 			:remark
      t.timestamps
    end
  end
end
