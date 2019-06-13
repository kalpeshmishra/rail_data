class CrackRake < ApplicationRecord

	def self.create_or_update_crack_rake(params)
  	crack_rake_data = {}
    (0..25).map{|no|crack_rake_data[no] = {}}
    params.each do |key,value|
      next if ["utf8","authenticity_token"].include?(key)
      no = key.split("_").last.to_i
      new_key = key.split("_")
      new_key.delete(key.split("_").last)
      new_key = new_key.join("_")
      crack_rake_data[no].merge!("#{new_key}" => value)

    end

    crack_rake_data.each do |key,value|
    	data_count = value.values.reject { |c| c.empty? }.count
      next if data_count == 0
      record_id = value["record_id"].to_i if value["record_id"].present?
      crack_rake = self.find(record_id) rescue nil if record_id.present?
      crack_rake = self.new if crack_rake.blank?
      crack_rake.train_name = value["train_name"].upcase rescue nil
			crack_rake.power_number = value["power_no"] rescue nil
			order_time = self.get_time(value["order_time"]) 
			crack_rake.order_time = order_time rescue nil
			crack_rake.order_date = value["order_date"] rescue nil
			onduty_time = self.get_time(value["onduty_time"])
			crack_rake.on_duty_time = onduty_time rescue nil
			crack_rake.on_duty_date = value["onduty_date"] rescue nil
			crack_rake.pre_departure_detnention = value["pre_departure"] rescue nil
			crack_rake.departure_station = value["station"] rescue nil
			departure_time = self.get_time(value["departure_time"])
			crack_rake.departure_time = departure_time rescue nil
			crack_rake.departure_date = value["departure_date"] rescue nil
			dhgarr_time = self.get_time(value["dhgarr_time"])
			crack_rake.dhg_arrival_time = dhgarr_time rescue nil
			crack_rake.dhg_arrival_date = value["dhgarr_date"] rescue nil
			crack_rake.tor_departure_dhg_arrival = value["tor_deptoarr"] rescue nil
			gimbarr_time = self.get_time(value["gimbarr_time"])
			crack_rake.gimb_arrival_time = gimbarr_time rescue nil
			crack_rake.gimb_arrival_date = value["gimbarr_date"] rescue nil
			offduty_time = self.get_time(value["offduty_time"])
			crack_rake.off_duty_time = offduty_time rescue nil
			crack_rake.off_duty_date = value["offduty_date"] rescue nil
			crack_rake.detention_on_to_off_duty = value["detn_ontooff"] rescue nil
			crack_rake.tor_departure_gimb_arrival = value["tor_deptogimbarr"] rescue nil
			crack_rake.remarks = value["remarks"] rescue nil
      crack_rake.save

      
    end
        
	end

  def self.data_crack_summary(crack_data)
    data_hash = {}
    station = crack_data.map{|e| e.departure_station}.uniq << "Total"
    station.each do |stn|  
      data_hash[stn] = {"trains" => 0,"pdd" => [],"tor_one" => [],"tor_two" => [],"on_off" => []}
    end
    crack_data.each do |data|
      data_hash[data.departure_station]["trains"] += 1 
      data_hash[data.departure_station]["pdd"] << data.pre_departure_detnention
      data_hash[data.departure_station]["tor_one"] << data.tor_departure_dhg_arrival
      data_hash[data.departure_station]["tor_two"] << data.tor_departure_gimb_arrival
      data_hash[data.departure_station]["on_off"] << data.detention_on_to_off_duty

      data_hash["Total"]["trains"] += 1 
      data_hash["Total"]["pdd"] << data.pre_departure_detnention
      data_hash["Total"]["tor_one"] << data.tor_departure_dhg_arrival
      data_hash["Total"]["tor_two"] << data.tor_departure_gimb_arrival
      data_hash["Total"]["on_off"] << data.detention_on_to_off_duty
    end
    return(data_hash)  
  end

	def self.get_time(time)
    if time.present?
      if time.split(":").count == 2
        proper_time = time + ":00"
      elsif time.split(":").count == 1
        proper_time = time + ":00" + ":00"
      elsif time.split(":").count == 3
        proper_time = time
      end
    else
       proper_time = nil 
    end
    proper_time
  end 



end
