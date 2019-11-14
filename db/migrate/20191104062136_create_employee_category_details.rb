class CreateEmployeeCategoryDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_category_details do |t|
    	t.integer 		:employee_id
    	t.string			:category_type
    	t.date				:date_in_level
    	t.integer			:employee_post_id
      t.string 			:letter_number
      t.date        :letter_date
      t.string      :remark
    	t.timestamps
    end
  end
end
