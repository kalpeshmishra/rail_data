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
      
      cadre_count = sanction_cadre.where(employee_post_id: no).present? ? sanction_cadre.where(employee_post_id: no).map{|x| x.number_of_post}.sum : 0
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
    cadre_stn_post_data = (man_on_roll.pluck(:station_id,:employee_post_id) + sanction_cadre.pluck(:station_id,:employee_post_id)).uniq.sort

    cadre_stn_post_data.each do |no|
      cadre_count = sanction_cadre.where(station_id: no[0],employee_post_id: no[1]).present? ? sanction_cadre.where(station_id: no[0],employee_post_id: no[1]).map{|x| x.number_of_post}.sum : 0
      mor_count = man_on_roll.where(station_id: no[0],employee_post_id: no[1]).count

      cat_id = cadre_post.find(no[1]).employee_category_id
      data_hash[no[0]] = {} if data_hash[no[0]].blank?
      data_hash[no[0]].merge![cat_id] = {} if data_hash[no[0]][cat_id].blank?
      data_hash[no[0]][cat_id].merge!(no[1] => [cadre_count,mor_count]) if data_hash[no[0]][cat_id][no[1]].blank?

    end
    
   return {header_hash: header_hash, data_hash: data_hash}

  end




end
