class CreateEmployeeMedicalDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_medical_details do |t|

      t.timestamps
    end
  end
end
