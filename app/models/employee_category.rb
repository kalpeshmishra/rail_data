class EmployeeCategory < ApplicationRecord
	belongs_to :employee_department
	has_many :employee_posts
end
