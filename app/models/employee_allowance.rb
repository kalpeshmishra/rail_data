class EmployeeAllowance < ApplicationRecord
	belongs_to :employee
	belongs_to :employee_post
	belongs_to :station

	def self.create_or_update_emp_allowance(params)
		emp_allowance_data = {}
		selected_employee = params["select_employee"].split(',').map!{|e| e.to_i}.delete_if {|x| x ==0}
		selected_employee.map{|no|emp_allowance_data[no] = {}}

		params.each do |key,value|
      next if ["utf8","authenticity_token","select_employee","controller","action"].include?(key)
      no = key.split("_").last.to_i
      new_key = key.split("_")
      new_key.delete(new_key.last)
      new_key = new_key.join("_")
      emp_allowance_data[no].merge!("#{new_key}" => value)
    end
		
    save_status = []  
    emp_allowance_data.each do |key,value|
      data_count = value.values.drop(5).reject { |c| c.empty? }.count
      next if data_count == 0
      record_id = value["record_id"].to_i if value["record_id"].present?
      emp_allowance = self.find(record_id) rescue nil if record_id.present?
      emp_allowance = self.new if emp_allowance.blank?
      
      emp_allowance.employee_post_id = value["post_id"].to_i rescue nil
      emp_allowance.employee_id = value["employee_id"].to_i rescue nil
      emp_allowance.station_id =  value["select_station"].to_i rescue nil
      emp_allowance.month = value["select_month"] rescue nil
      emp_allowance.over_time_hours = value["over_time_hours"] rescue nil
      emp_allowance.over_time_minutes = value["over_time_minutes"] rescue nil
      emp_allowance.over_time_amount = value["over_time_amount"] rescue nil
      emp_allowance.transpotation_days = value["transpotation_days"] rescue nil
    	emp_allowance.transpotation_amount = value["transpotation_amount"] rescue nil
      emp_allowance.contingency_amount = value["contingency_amount"] rescue nil
      emp_allowance.remark = value["remark"] rescue nil
      emp_allowance.save
      if emp_allowance.save
        save_status << true
      end
    end
    return save_status.include?(true)
	end	

end
