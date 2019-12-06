class EmployeeCadre < ApplicationRecord
	belongs_to :station
	belongs_to :employee_post

	def self.create_or_update_employee_cadre(params)
		employee_cadre_data = {}
   
    (0..20).map{|no|employee_cadre_data[no] = {}}
    params.each do |key,value|
      next if ["utf8","authenticity_token","selected_station","controller","action"].include?(key)
    	no = key.split("_").last.to_i
      new_key = key.split("_")
      new_key.delete(key.split("_").last)
      new_key = new_key.join("_")
      employee_cadre_data[no].merge!("#{new_key}" => value)
    end
    	
    employee_cadre_data.each do |key,value|
      data_count = value.values.reject { |c| c.empty? }.count
      next if data_count == 0
      record_id = value["record_id"].to_i if value["record_id"].present?
      employee_cadre = self.find(record_id) rescue nil if record_id.present?
      employee_cadre = self.new if employee_cadre.blank?

    	employee_cadre.station_id = params["selected_station"].to_i rescue nil
      employee_cadre.employee_post_id = value["employee_cadre_post"].to_i rescue nil
      employee_cadre.number_of_post = value["post_number"].to_i rescue nil
      employee_cadre.remark = value["remarks"] rescue nil
      employee_cadre.save
    end

	end

  def self.get_cadre_with_total(sanction_cadre,man_on_roll)
    data_hash = {}  
    select_present_cadre = (man_on_roll.pluck(:employee_post_id) + sanction_cadre.pluck(:employee_post_id)).uniq.sort
    select_present_cadre.each do |no|
      data = sanction_cadre.find_by(employee_post_id: no).present? ?sanction_cadre.find_by(employee_post_id: no) : man_on_roll.find_by(employee_post_id: no)
    
      emp_category = data.employee_post.employee_category
      cadre_count = sanction_cadre.find_by(employee_post_id: no).present? ? data.number_of_post : 0
      mor_count = man_on_roll.where(employee_post_id: no).count
      
      if data_hash[emp_category].present?
        if data_hash[emp_category][data.employee_post].present?
          data_hash[emp_category][data.employee_post][0] +=cadre_count 
        else  
          data_hash[emp_category].merge!(data.employee_post => [cadre_count,mor_count]) 
        end
      else  
        data_hash[emp_category] = {}
        if data_hash[emp_category][data.employee_post].present?
          data_hash[emp_category][data.employee_post][0] +=cadre_count 
        else
          data_hash[emp_category].merge!(data.employee_post => [cadre_count,mor_count]) 
        end
      end
      
    end
        
    return data_hash
  end

  def self.get_cadre_station_data(sanction_cadre,man_on_roll)
    cadre_post_ids = (man_on_roll.pluck(:employee_post_id) + sanction_cadre.pluck(:employee_post_id)).uniq.sort
    cadre_station_ids = (man_on_roll.pluck(:station_id) + sanction_cadre.pluck(:station_id)).uniq.sort
    cadre_post = EmployeePost.where(id: cadre_post_ids)
    header_hash = {}
    cadre_post.each do |data|
      if header_hash[data.employee_category].blank?
        header_hash[data.employee_category] = [data]
      else
        header_hash[data.employee_category] << data
      end  
    end  

    data_hash = {}
    cadre_station_ids.map{|stn| data_hash[stn] = {} }
    
    cadre_post_ids.each do |no|
      data = sanction_cadre.find_by(employee_post_id: no).present? ?sanction_cadre.find_by(employee_post_id: no) : man_on_roll.find_by(employee_post_id: no)
      emp_category_id = data.employee_post.employee_category_id
      emp_post_id = data.employee_post_id
      emp_station_id = data.station_id


      # binding.pry


      data_hash
    end  


   return {header_hash: header_hash}

  end




end
