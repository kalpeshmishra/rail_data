class EmployeePost < ApplicationRecord
	belongs_to :employee_department
	belongs_to :employee_category
	has_many :employee_category_details
end
