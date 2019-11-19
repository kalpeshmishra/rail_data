class CreateEmployeeMedicalDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_medical_details do |t|
    	t.integer 		:employee_id
    	t.integer			:employee_category_id
    	t.string 			:medical_type
    	t.string      :medical_category
    	t.date 				:medical_date
      t.date        :fit_date
    	t.date 				:next_due_date
    	t.string 			:certificate_no
    	t.string 			:issued_by   # CMS or Hospital
      t.string      :remark  
    	t.timestamps
    end
  end
end
