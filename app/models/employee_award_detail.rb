class EmployeeAwardDetail < ApplicationRecord
	belongs_to :employee

	def self.create_employee_award(params)
		EmployeeAwardDetail.create(employee_id: params[:award_employee_id], award_category: params[:award_category], award_date: params[:award_date], reason: params[:award_reason])
	end


end
