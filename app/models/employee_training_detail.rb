class EmployeeTrainingDetail < ApplicationRecord
	belongs_to :employee
	belongs_to :employee_category

	def self.create_employee_training(params)
		EmployeeTrainingDetail.create(employee_id: params[:training_employee_id], employee_category_id: params[:training_category], start_date: params[:training_start_date], end_date: params[:training_end_date], training_type: params[:training_type], next_due_date: params[:training_due_date], certificate_no: params[:training_certificate_no], grade_received: params[:training_grade], training_center: params[:training_center], remark: params[:training_remark])
	end

	

end
