class RakeUnload < ApplicationRecord
belongs_to :load_unload
belongs_to :station
belongs_to :major_commodity
belongs_to :wagon_type


  def self.create_or_update_rake_unload(params)
    rake_unload_data = {}
    (0..55).map{|no|rake_unload_data[no] = {}}
    params.each do |key,value|
      next if ["utf8","authenticity_token"].include?(key)
      no = key.split("_").last.to_i
      new_key = key.split("_")
      new_key.delete(key.split("_").last)
      new_key = new_key.join("_")
      rake_unload_data[no].merge!("#{new_key}" => value)

    end

    rake_unload_data.each do |key,value|
      data_count = value.values.reject { |c| c.empty? }.count
      next if data_count == 0
      record_id = value["record_id"].to_i if value["record_id"].present?
      rake_unload = self.find(record_id) rescue nil if record_id.present?
      rake_unload = self.new if rake_unload.blank?

      from_station = Station.where(code: value["from_station"]).pluck(:id)
      rake_unload.station_id = from_station[0].to_i rescue nil
      to_station = Station.where(code: value["to_station"]).pluck(:id)
      load_unload = LoadUnload.where(station_id: to_station).pluck(:id)
      rake_unload.load_unload_id = load_unload[0].to_i rescue nil
      

      # rake_unload.station_id = value["from_station"].to_i rescue nil
      # rake_unload.load_unload_id = value["to_station"].to_i rescue nil
      rake_unload.loaded_unit = value["loaded_unit"] rescue nil
      rake_unload.total_unit = value["total_unit"] rescue nil
      rake_unload.wagon_type_id = value["wagon_type"].to_i rescue nil
      rake_unload.rake_count = value["rake_count"] rescue nil
      rake_unload.stock_description = value["stock_description"] rescue nil

      rake_unload.major_commodity_id = value["major_commodity"].to_i rescue nil
      mcommodity = MajorCommodity.where(:id => rake_unload.major_commodity_id).pluck(:major_commodity) 
      if mcommodity == ["CONT"]
        rake_unload.stack = value["stack"] rescue nil
      else
        rake_unload.stack = "" rescue nil
      end
     
      rake_unload.bpc_station = value["bpc_station"] rescue nil
      rake_unload.bpc_date = value["bpc_date"] rescue nil
      rake_unload.bpc_type = value["bpc_type"] rescue nil
      rake_unload.bpc_validity = value["bpc_validity"] rescue nil

      arrival_time = self.get_time(value["arrival_time"]) 
      rake_unload.arrival_time = arrival_time rescue nil
      rake_unload.arrival_date = value["arrival_date"] rescue nil
      placement_time = get_time(value["placement_time"]) 
      rake_unload.placement_time = placement_time rescue nil
      rake_unload.placement_date = value["placement_date"] rescue nil
      release_time = get_time(value["release_time"])
      rake_unload.release_time = release_time rescue nil
      rake_unload.release_date = value["release_date"] rescue nil
      rake_unload.detention_arrival_placement = value["detention_arrival_placement"] rescue nil
      rake_unload.detention_placement_release = value["detention_placement_release"] rescue nil
      rake_unload.remarks = value["remarks"] rescue nil
      rake_unload.form_status = "RAKE"
      rake_unload.save

      
    end
        
  end 

  def self.create_or_update_one_rake_unload(params)
    one_rake_unloads_data = {}
    (0...55).map{|no|one_rake_unloads_data[no] = {}}
    params.each do |key,value|
      next if ["utf8","authenticity_token"].include?(key)
      no = key.split("_").last.to_i
      new_key = key.split("_")
      new_key.delete(key.split("_").last)
      new_key = new_key.join("_")
      one_rake_unloads_data[no].merge!("#{new_key}" => value)

    end
     one_rake_unloads_data.each do |key,value|
      data_count = value.values.reject { |c| c.empty? }.count
      next if data_count == 0
      record_id = value["record_id"].to_i if value["record_id"].present?
      one_rake_unloads = self.find(record_id) rescue nil if record_id.present?
      one_rake_unloads = self.new if one_rake_unloads.blank?
      one_rake_unloads.removal_time = value["removal_time"] rescue nil
      one_rake_unloads.removal_date = value["removal_date"] rescue nil
      #commodity break up pending
      one_rake_unloads.commodity_type = value["commodity_type"] rescue nil
      one_rake_unloads.tue_first_row = value["tue_first_row"] rescue nil
      one_rake_unloads.tue_second_row = value["tue_second_row"] rescue nil
      one_rake_unloads.consignor = value["consignor"] rescue nil
      one_rake_unloads.consignee = value["consignee"] rescue nil
      one_rake_unloads.status = value["status"] rescue nil
      one_rake_unloads.power_no = value["power_no"] rescue nil
      one_rake_unloads.powerarrival_time = value["powerarrival_time"] rescue nil
      one_rake_unloads.powerarrival_date = value["powerarrival_date"] rescue nil
      one_rake_unloads.stable_time = value["stable_time"] rescue nil
      one_rake_unloads.stable_date = value["stable_date"] rescue nil
      one_rake_unloads.departure_time =value["departure_time"] rescue nil
      one_rake_unloads.departure_date = value["departure_date"] rescue nil
      one_rake_unloads.detention_release_removal =value["detention_release_removal"] rescue nil
      one_rake_unloads.detention_release_removal = value["detention_release_removal"] rescue nil
      one_rake_unloads.remarks = value["remarks"] rescue nil
      one_rake_unloads.empty_rake_release_id = value["empty_rake_release_id"] rescue nil
      one_rake_unloads.save

      
    end
    
  end

  def RakeUnload.create_or_update_other_unload(params)
    other_unload_data = {}

    (0..25).map{|no|other_unload_data[no] = {}}
    params.each do |key,value|
      next if ["utf8","authenticity_token"].include?(key)
      no = key.split("_").last.to_i
      new_key = key.split("_")
      new_key.delete(key.split("_").last)
      new_key = new_key.join("_")
      other_unload_data[no].merge!("#{new_key}" => value)
    end

      other_unload_data.each do |key,value|
      data_count = value.values.reject { |c| c.empty? }.count
      next if data_count == 0
      record_id = value["record_id"].to_i if value["record_id"].present?
      other_unload = self.find(record_id) rescue nil if record_id.present?
      other_unload = self.new if other_unload.blank?

      from_station = Station.where(code: value["from_station"]).pluck(:id)
      other_unload.station_id = from_station[0].to_i rescue nil
      to_station = Station.where(code: value["to_station"]).pluck(:id)
      load_unload = LoadUnload.where(station_id: to_station).pluck(:id)
      other_unload.load_unload_id = load_unload[0].to_i rescue nil

      other_unload.loaded_unit = value["loaded_unit"] rescue nil
      other_unload.rake_count = value["rake_count"] rescue nil
      other_unload.major_commodity_id = value["major_commodity"].to_i rescue nil
      other_unload.wagon_type_id = value["wagon_type"].to_i rescue nil
      release_time = get_time(value["release_time"])
      other_unload.release_time = release_time rescue nil
      other_unload.release_date = value["release_date"] rescue nil
      other_unload.remarks = value["remarks"] rescue nil
      other_unload.form_status = "OTHER"
      other_unload.save

      
    end
        
  end 

  def RakeUnload.create_or_update_gets_unload(params)
    gets_unload_data = {}

    (0..25).map{|no|gets_unload_data[no] = {}}
    params.each do |key,value|
      next if ["utf8","authenticity_token"].include?(key)
      no = key.split("_").last.to_i
      new_key = key.split("_")
      new_key.delete(key.split("_").last)
      new_key = new_key.join("_")
      gets_unload_data[no].merge!("#{new_key}" => value)
    end

      gets_unload_data.each do |key,value|
      data_count = value.values.reject { |c| c.empty? }.count
      next if data_count == 0
      record_id = value["record_id"].to_i if value["record_id"].present?
      gets_unload = self.find(record_id) rescue nil if record_id.present?
      gets_unload = self.new if gets_unload.blank?

      from_station = Station.where(code: value["from_station"]).pluck(:id)
      gets_unload.station_id = from_station[0].to_i rescue nil
      to_station = Station.where(code: value["to_station"]).pluck(:id)
      load_unload = LoadUnload.where(station_id: to_station).pluck(:id)
      gets_unload.load_unload_id = load_unload[0].to_i rescue nil

      gets_unload.takenover_point = value["takenover_point"] rescue nil
      gets_unload.collary = value["collary"] rescue nil
      takenover_time = value["takenover_time"]
      gets_unload.takenover_time = takenover_time rescue nil
      gets_unload.takenover_date = value["takenover_date"] rescue nil
      gets_unload.loaded_unit = value["loaded_unit"] rescue nil
      gets_unload.total_unit = value["total_unit"] rescue nil
      gets_unload.wagon_type_id = value["wagon_type"].to_i rescue nil
      gets_unload.rake_count = value["rake_count"] rescue nil
      gets_unload.incoming_power = value["incoming_power"] rescue nil
      gets_unload.stock_description = value["stock_description"] rescue nil
      gets_unload.major_commodity_id = value["major_commodity"].to_i rescue nil
      gets_unload.commodity_type = value["commodity_type"] rescue nil
      gets_unload.bpc_station = value["bpc_station"] rescue nil
      gets_unload.bpc_date = value["bpc_date"] rescue nil
      gets_unload.bpc_type = value["bpc_type"] rescue nil
      gets_unload.bpc_validity = value["bpc_validity"] rescue nil
      #Arrival and placement are same at powerhouse i.e. GETS & AECS
      placement_time = get_time(value["placement_time"])
      gets_unload.arrival_time = placement_time rescue nil
      gets_unload.arrival_date = value["placement_date"] rescue nil 
      gets_unload.placement_time = placement_time rescue nil
      gets_unload.placement_date = value["placement_date"] rescue nil
      release_time = get_time(value["release_time"])
      gets_unload.release_time = release_time rescue nil
      gets_unload.release_date = value["release_date"] rescue nil
      gets_unload.train_on_run_hours =value["train_on_run_hours"] rescue nil
      gets_unload.detention_placement_release = value["detention_placement_release"] rescue nil
      gets_unload.power_no = value["power_no"] rescue nil
      powerarrival_time = value["powerarrival_time"]
      gets_unload.powerarrival_time = powerarrival_time rescue nil
      gets_unload.powerarrival_date = value["powerarrival_date"] rescue nil
      # Removal and departure are same in PowerHouse(GETS-AECS)
      departure_time = value["departure_time"]
      gets_unload.departure_time = departure_time rescue nil
      gets_unload.departure_date = value["departure_date"] rescue nil
      gets_unload.removal_time = departure_time rescue nil
      gets_unload.removal_date = value["departure_date"] rescue nil
      handedover_time = value["handedover_time"]
      gets_unload.handedover_time = handedover_time rescue nil
      gets_unload.handedover_date = value["handedover_date"] rescue nil
      gets_unload.handedover_point = value["handedover_point"] rescue nil
      gets_unload.empty_destination = value["empty_destination"] rescue nil
      gets_unload.detention_for_power = value["detention_for_power"] rescue nil
      gets_unload.powerarrival_train_departure = value["powerarrival_train_departure"] rescue nil
      gets_unload.detention_ger_to_ger_tor = value["detention_ger_to_ger_tor"] rescue nil
      gets_unload.detention_in_out = value["detention_in_out"] rescue nil
      gets_unload.remarks = value["remarks"] rescue nil
      gets_unload.form_status = "GETS"
      gets_unload.save

      
    end
        
  end 

  def RakeUnload.create_or_update_aecs_unload(params)
    aecs_unload_data = {}

    (0..25).map{|no|aecs_unload_data[no] = {}}
    params.each do |key,value|
      next if ["utf8","authenticity_token"].include?(key)
      no = key.split("_").last.to_i
      new_key = key.split("_")
      new_key.delete(key.split("_").last)
      new_key = new_key.join("_")
      aecs_unload_data[no].merge!("#{new_key}" => value)
    end

      aecs_unload_data.each do |key,value|
      data_count = value.values.reject { |c| c.empty? }.count
      next if data_count == 0
      record_id = value["record_id"].to_i if value["record_id"].present?
      aecs_unload = self.find(record_id) rescue nil if record_id.present?
      aecs_unload = self.new if aecs_unload.blank?

      from_station = Station.where(code: value["from_station"]).pluck(:id)
      aecs_unload.station_id = from_station[0].to_i rescue nil
      to_station = Station.where(code: value["to_station"]).pluck(:id)
      load_unload = LoadUnload.where(station_id: to_station).pluck(:id)
      aecs_unload.load_unload_id = load_unload[0].to_i rescue nil

      aecs_unload.takenover_point = value["takenover_point"] rescue nil
      aecs_unload.collary = value["collary"] rescue nil
      takenover_time = value["takenover_time"]
      aecs_unload.takenover_time = takenover_time rescue nil
      aecs_unload.takenover_date = value["takenover_date"] rescue nil
      aecs_unload.loaded_unit = value["loaded_unit"] rescue nil
      aecs_unload.total_unit = value["total_unit"] rescue nil
      aecs_unload.wagon_type_id = value["wagon_type"].to_i rescue nil
      aecs_unload.rake_count = value["rake_count"] rescue nil
      aecs_unload.incoming_power = value["incoming_power"] rescue nil
      aecs_unload.stock_description = value["stock_description"] rescue nil
      aecs_unload.major_commodity_id = value["major_commodity"].to_i rescue nil
      aecs_unload.commodity_type = value["commodity_type"] rescue nil
      aecs_unload.bpc_station = value["bpc_station"] rescue nil
      aecs_unload.bpc_date = value["bpc_date"] rescue nil
      aecs_unload.bpc_type = value["bpc_type"] rescue nil
      aecs_unload.bpc_validity = value["bpc_validity"] rescue nil
      aecs_unload.power_no = value["power_no"] rescue nil
      #Arrival and placement are same at powerhouse i.e. GETS & AECS
      placement_time = get_time(value["placement_time"])
      aecs_unload.arrival_time = placement_time rescue nil
      aecs_unload.arrival_date = value["placement_date"] rescue nil 
      aecs_unload.placement_time = placement_time rescue nil
      aecs_unload.placement_date = value["placement_date"] rescue nil
      release_time = get_time(value["release_time"])
      aecs_unload.release_time = release_time rescue nil
      aecs_unload.release_date = value["release_date"] rescue nil
      aecs_unload.train_on_run_hours =value["train_on_run_hours"] rescue nil
      aecs_unload.detention_placement_release = value["detention_placement_release"] rescue nil
      powerarrival_time = value["powerarrival_time"]
      aecs_unload.powerarrival_time = powerarrival_time rescue nil
      aecs_unload.powerarrival_date = value["powerarrival_date"] rescue nil
      # Removal and departure are same in PowerHouse(GETS-AECS)
      departure_time = value["departure_time"]
      aecs_unload.departure_time = departure_time rescue nil
      aecs_unload.departure_date = value["departure_date"] rescue nil
      aecs_unload.removal_time = departure_time rescue nil
      aecs_unload.removal_date = value["departure_date"] rescue nil
      handedover_time = value["handedover_time"]
      aecs_unload.handedover_time = handedover_time rescue nil
      aecs_unload.handedover_date = value["handedover_date"] rescue nil
      aecs_unload.handedover_point = value["handedover_point"] rescue nil
      aecs_unload.empty_destination = value["empty_destination"] rescue nil
      aecs_unload.detention_for_power = value["detention_for_power"] rescue nil
      aecs_unload.powerarrival_train_departure = value["powerarrival_train_departure"] rescue nil
      aecs_unload.detention_ger_to_ger_tor = value["detention_ger_to_ger_tor"] rescue nil
      aecs_unload.detention_in_out = value["detention_in_out"] rescue nil
      aecs_unload.remarks = value["remarks"] rescue nil
      aecs_unload.form_status = "AECS"
      aecs_unload.save

      
    end
        
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
