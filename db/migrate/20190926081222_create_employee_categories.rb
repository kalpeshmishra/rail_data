class CreateEmployeeCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_categories do |t|
    	t.integer :employee_department_id
    	t.string :name
    	t.string :group
      t.timestamps
    end
  end
end
