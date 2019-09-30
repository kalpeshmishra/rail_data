class AllowanceSummary < ApplicationRecord
	belongs_to :employee_category
	belongs_to :station


	def self.create_or_update_allowance(params)
		allowance_data = {}
		selected_category = params["s_category"].split(',').map!{|e| e.to_i}.delete_if {|x| x ==0}
		selected_category.map{|no|allowance_data[no] = {}}

		params.each do |key,value|
      next if ["utf8","authenticity_token","s_category","controller","action"].include?(key)
      no = key.split("_").last.to_i
      new_key = key.split("_")
      new_key.delete(key.split("_").last)
      new_key = new_key.join("_")
      allowance_data[no].merge!("#{new_key}" => value)
    end  
    allowance_data.each do |key,value|
      data_count = value.values.reject { |c| c.empty? }.count
      next if data_count == 0
      record_id = value["record_id"].to_i if value["record_id"].present?
      allowance = self.find(record_id) rescue nil if record_id.present?
      allowance = self.new if allowance.blank?

      allowance.employee_category_id = value["category_id"].to_i rescue nil
      allowance.station_id =  value["s_station"].to_i rescue nil
      allowance.month = value["s_month"] rescue nil
      allowance.over_time_hours = value["over_time_hours"] rescue nil
      allowance.over_time_minutes = value["over_time_minutes"] rescue nil
      allowance.over_time_amount = value["over_time_amount"] rescue nil
      allowance.transpotation_days = value["transpotation_days"] rescue nil
    	allowance.transpotation_amount = value["transpotation_amount"] rescue nil
      allowance.contingency_amount = value["contingency_amount"] rescue nil
      # allowance.remark = 
      allowance.save
    end

	end	



end
