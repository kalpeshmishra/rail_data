class EmployeeTrainingDetail < ApplicationRecord
	belongs_to :employee
	belongs_to :employee_category
end
