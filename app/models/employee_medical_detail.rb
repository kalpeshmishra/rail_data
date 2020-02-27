class EmployeeMedicalDetail < ApplicationRecord
	belongs_to :employee
	belongs_to :employee_category

	def self.create_employee_medical(params)
		EmployeeMedicalDetail.create(employee_id: params[:medical_employee_id], employee_category_id: params[:medical_employee_category], medical_type: params[:medical_type], medical_category: params[:medical_category], medical_date: params[:medical_date], fit_date: params[:medical_fit_date], next_due_date: params[:medical_due_date], certificate_no: params[:medical_certificate_no], issued_by: params[:medical_type], remark: params[:medical_remark])
	end




end
