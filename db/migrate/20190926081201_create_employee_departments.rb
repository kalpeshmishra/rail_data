class CreateEmployeeDepartments < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_departments do |t|
    	t.string :name
      t.timestamps
    end
  end
end
