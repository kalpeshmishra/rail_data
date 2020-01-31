class CreateEmployeeAllowances < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_allowances do |t|
    	t.integer		:employee_id	
    	t.integer		:employee_category_id	
    	t.integer   :station_id
    	t.string    :month
    	t.string    :over_time_hours
    	t.string    :over_time_minutes
    	t.string    :over_time_amount
    	t.string    :transpotation_days
    	t.string    :transpotation_amount
    	t.string    :contingency_amount
      t.string    :extra
      t.string    :reason
    	t.string    :remark
      t.timestamps
    end
  end
end
