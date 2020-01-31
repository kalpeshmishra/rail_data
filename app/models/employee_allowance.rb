class EmployeeAllowance < ApplicationRecord
	belongs_to :employee
	belongs_to :employee_category
	belongs_to :station
end
