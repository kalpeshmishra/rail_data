class CreateEmployeeDarDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_dar_details do |t|
      t.integer   :employee_id
    	t.string 		:dar_type
    	t.date  		:issue_date
    	t.date 			:received_at_station
    	t.date 			:acknowledge_by_employee
    	t.date 			:defense_submit_by_employee
    	t.date 			:employee_defense_sent_to_dar
    	t.date 			:nip_received_date
    	t.date 			:nip_acknowledge_sent_to_dar
    	t.date 			:sf_7_issue
    	t.date 			:finding_report_issue_date
    	t.date 			:acknowledge_finding_report
    	t.string 		:remark
      t.timestamps
    end
  end
end
