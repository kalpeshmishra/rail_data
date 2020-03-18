class EmployeeCategoryDetail < ApplicationRecord
	belongs_to :employee
	belongs_to :employee_post

	after_save :update_employee_current_post
	after_destroy :update_employee_current_post


	def update_employee_current_post
		temp_emp_data = EmployeeCategoryDetail.where(employee_id: employee_id)
		if temp_emp_data.count>0
			emp_post_id = temp_emp_data.order('date_in_level ASC').last.employee_post_id
			Employee.find(employee_id).update(employee_post_id: emp_post_id)
		end
	end
	
	def self.create_employee_category(params)
		EmployeeCategoryDetail.create(employee_id: params[:category_employee_id],employee_post_id: params[:add_category_post], category_type: params[:category_type],date_in_level: params[:category_date], letter_number: params[:category_letter_number], letter_date: params[:category_letter_date] , remark: params[:add_category_remark])
	end

end
