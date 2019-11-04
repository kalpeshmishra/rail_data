class CreateEmployeeCategoryDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_category_details do |t|
    	t.string			:type
    	t.date				:date_in_level
    	t.integer			:employee_post_id
    	t.string 			:remark
    	t.timestamps
    end
  end
end
