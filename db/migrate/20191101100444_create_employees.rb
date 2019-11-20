class CreateEmployees < ActiveRecord::Migration[5.0]
  def change
    create_table :employees do |t|
    	t.string		:first_name
    	t.string		:last_name
    	t.string  	:father_name
    	t.string 		:spouse_name
      t.string    :mother_name
    	t.string 		:emp_number   #PF number OR NPS number
    	t.string 		:pran_number
    	t.string		:pan_number
    	t.string		:aadhaar
    	t.string 		:gender
    	t.string 		:religion
    	t.string 		:community
    	t.date 			:birth_date
    	t.string 		:marital_status
    	t.string 		:disability
    	t.date 			:appointment_date
    	t.string		:permanent_address
    	t.string		:temporary_address
    	t.string  	:mobile_no
    	t.string		:alternate_number
    	t.string 		:email_id
    	t.string		:appointment_mode
      t.integer   :employee_post_id       #Last post Id of Employee
      t.integer   :station_id             #Last posting station
    	t.string		:image_path
      t.string    :in_service
      t.timestamps
    end
  end
end
