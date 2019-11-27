class EmployeeDarDetail < ApplicationRecord
	belongs_to :employee

	def self.create_employee_dar(params)
		EmployeeDarDetail.create(employee_id: params[:employee_id],dar_type: params[:emp_dar_type], issue_date: params[:emp_dar_issue_date], received_at_station: params[:emp_received_at_station_date], acknowledge_by_employee: params[:emp_employee_acknowledge_date], defense_submit_by_employee: params[:emp_defense_submit_by_employee_date], employee_defense_sent_to_dar: params[:emp_defense_acknowledge_sent_to_dar_date], nip_acknowledge_sent_to_dar: params[:emp_nip_acknowledge_sent_to_dar_date], sf_7_issue: params[:emp_sf_7_issue_date], nip_received_date: params[:emp_nip_received_date], finding_report_issue_date: params[:emp_finding_report_issue_date], acknowledge_finding_report: params[:emp_acknowledge_finding_report], remark: params[:emp_dar_remark]) 
	end
end
