class EmployeePost < ApplicationRecord
	belongs_to :employee_department
	belongs_to :employee_category
end
