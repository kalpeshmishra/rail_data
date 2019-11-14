class EmployeeCategoryDetail < ApplicationRecord
	belongs_to :employee
	belongs_to :employee_post
	
	def self.create_employee_category(params)
		EmployeeCategoryDetail.create(employee_id: params[:employee_id],employee_post_id: params[:emp_post_id], category_type: params[:emp_category_type],date_in_level: params[:emp_in_category_date], letter_number: params[:emp_category_letter_number], letter_date: params[:emp_category_letter_date] , remark: params[:emp_add_category_remark])
	end

end
