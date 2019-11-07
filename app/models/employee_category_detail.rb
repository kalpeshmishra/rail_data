class EmployeeCategoryDetail < ApplicationRecord
	belongs_to :employee
	belongs_to :employee_post
	
end
