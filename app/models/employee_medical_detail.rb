class EmployeeMedicalDetail < ApplicationRecord
	belongs_to :employee
	belongs_to :employee_category

	def self.create_employee_medical(params)
		EmployeeMedicalDetail.create(employee_id: params[:employee_id], employee_category_id: params[:emp_medical_employee_category_id], medical_type: params[:emp_medical_type], medical_category: params[:emp_medical_category], medical_date: params[:emp_medical_date], fit_date: params[:emp_medical_fit_date], next_due_date: params[:emp_medical_due_date], certificate_no: params[:emp_medical_certificate_no], issued_by: params[:emp_medical_type], remark: params[:emp_medical_remark])
	end




end
