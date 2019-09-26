class EmployeeDepartment < ApplicationRecord
	has_many :employee_categories
	has_many :employee_posts 
end
