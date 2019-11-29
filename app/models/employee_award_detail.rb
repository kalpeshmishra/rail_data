class EmployeeAwardDetail < ApplicationRecord
	belongs_to :employee

	def self.create_employee_award(params)
		EmployeeAwardDetail.create(employee_id: params[:employee_id], award_category: params[:emp_award_category], award_date: params[:emp_award_date], reason: params[:emp_award_reason])
	end


end
