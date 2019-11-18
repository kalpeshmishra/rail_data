class EmployeeTrainingDetail < ApplicationRecord
	belongs_to :employee
	belongs_to :employee_category

	def self.create_employee_training(params)
		EmployeeTrainingDetail.create(employee_id: params[:employee_id], employee_category_id: params[:emp_training_category_id], start_date: params[:emp_training_start_date], end_date: params[:emp_training_end_date], training_type: params[:emp_training_type], next_due_date: params[:emp_training_due_date], certificate_no: params[:emp_training_certificate_no], grade_received: params[:emp_training_grade], training_center: params[:emp_training_center], remark: params[:emp_training_remark])
	end

	

end
