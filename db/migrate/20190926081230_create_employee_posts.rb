class CreateEmployeePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_posts do |t|
    	t.integer 	:employee_department_id
    	t.integer		:employee_category_id	
    	t.string 		:group
    	t.string 		:post	
    	t.string 		:post_code	
    	t.string 		:pay_band_p6   #p6 menas Sixth pay commission	
    	t.string    :grade_pay_p6	
    	t.integer   :level_p7      #p7 means Seventh pay commission 
      t.string    :report_group   
      t.timestamps
    end
  end
end
