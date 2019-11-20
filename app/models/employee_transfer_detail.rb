class EmployeeTransferDetail < ApplicationRecord
	belongs_to :employee
	belongs_to :station

	after_save :update_employee_current_station
	after_destroy :update_employee_current_station


	def update_employee_current_station
		temp_emp_data = EmployeeTransferDetail.where(employee_id: employee_id)
		if temp_emp_data.count>0
			emp_station_id = temp_emp_data.order('resume_date ASC').last.station_id
			Employee.find(employee_id).update(station_id: emp_station_id)
		end
	end

	def self.create_employee_transfer(params)
		EmployeeTransferDetail.create(employee_id: params[:employee_id],station_id: params[:emp_station_id], transfer_type: params[:emp_transfer_type],transfer_date: params[:emp_transfer_date], letter_number: params[:emp_transfer_letter_number], resume_date: params[:emp_transfer_resume_date] , remark: params[:emp_add_transfer_remark])
	end

end
