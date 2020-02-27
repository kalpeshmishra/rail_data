class CreateEmployeeFamilyDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_family_details do |t|
    	t.integer 		:employee_id
    	t.string			:name
      t.string      :relation
    	t.string 			:gender
    	t.string			:marital_status
    	t.string			:dependancy
    	t.string			:physicaly_challanged
    	t.string			:blood_group
    	t.string			:aadhaar
    	t.string			:mobile
      t.date        :birth_date
    	t.string			:remarks
    	t.string			:extra

      t.timestamps
    end
  end
end
