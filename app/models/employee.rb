class Employee < ApplicationRecord
	belongs_to :station
	belongs_to :employee_post
	has_many	 :employee_category_details
end
