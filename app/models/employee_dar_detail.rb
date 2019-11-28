class EmployeeDarDetail < ApplicationRecord
	belongs_to :employee

	def self.create_employee_dar(params)

		dar_record_id = params["emp_dar_record_id"].to_i if params["emp_dar_record_id"].present?
		dar = self.find(dar_record_id) rescue nil if dar_record_id.present?
    dar = self.new if dar.blank?

    dar.employee_id = params[:employee_id] rescue nil
    dar.dar_type = params[:emp_dar_type] rescue nil
    dar.issue_date = params[:emp_dar_issue_date] rescue nil
    dar.received_at_station = params[:emp_received_at_station_date] rescue nil
    dar.acknowledge_by_employee = params[:emp_employee_acknowledge_date] rescue nil
    dar.defense_submit_by_employee = params[:emp_defense_submit_by_employee_date] rescue nil
    dar.employee_defense_sent_to_dar = params[:emp_defense_acknowledge_sent_to_dar_date] rescue nil
    dar.nip_acknowledge_sent_to_dar = params[:emp_nip_acknowledge_sent_to_dar_date] rescue nil
    dar.sf_7_issue = params[:emp_sf_7_issue_date] rescue nil
    dar.nip_received_date = params[:emp_nip_received_date] rescue nil
    dar.finding_report_issue_date = params[:emp_finding_report_issue_date] rescue nil
    dar.acknowledge_finding_report = params[:emp_acknowledge_finding_report] rescue nil
    dar.remark = params[:emp_dar_remark] rescue nil
    dar.save

	 
	end
end
