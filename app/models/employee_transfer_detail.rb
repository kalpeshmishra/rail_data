class EmployeeTransferDetail < ApplicationRecord
	belongs_to :employee
	belongs_to :station

	def self.create_employee_transfer(params)
		EmployeeTransferDetail.create(employee_id: params[:employee_id],station_id: params[:emp_station_id], transfer_type: params[:emp_transfer_type],transfer_date: params[:emp_transfer_date], letter_number: params[:emp_transfer_letter_number], resume_date: params[:emp_transfer_resume_date] , remark: params[:emp_add_transfer_remark])
	end

end
