class RakeUnload < ApplicationRecord
belongs_to :load_unload
belongs_to :station
belongs_to :major_commodity
belongs_to :wagon_type
has_many :rake_unloads_rake_commodities



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
      rake_unload.stock_description = value["stock_description"].squish rescue nil

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
      rake_unload.remarks = value["remarks"].squish rescue nil
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
      one_rake_unloads.detention_removal_departure = value["detention_removal_departure"] rescue nil
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
      gets_unload.stock_description = value["stock_description"].squish rescue nil
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
      power_detention = value["detention_for_power"]
      power_arr_train_dep_detention = value["powerarrival_train_departure"]
      if power_detention == "NA"
        power_detention = ""
      elsif power_arr_train_dep_detention == "NA"
        power_arr_train_dep_detention = ""
      end
      release_to_removal_detn = [power_detention,power_arr_train_dep_detention].reject(&:blank?).sum_strings(':')
      gets_unload.detention_release_removal = release_to_removal_detn rescue nil
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
      aecs_unload.stock_description = value["stock_description"].squish rescue nil
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
      power_detention = value["detention_for_power"]
      power_arr_train_dep_detention = value["powerarrival_train_departure"]
      if power_detention == "NA"
        power_detention = ""
      elsif power_arr_train_dep_detention == "NA"
        power_arr_train_dep_detention = ""
      end
      release_to_removal_detn = [power_detention,power_arr_train_dep_detention].reject(&:blank?).sum_strings(':')
      aecs_unload.detention_release_removal = release_to_removal_detn rescue nil
      aecs_unload.detention_ger_to_ger_tor = value["detention_ger_to_ger_tor"] rescue nil
      aecs_unload.detention_in_out = value["detention_in_out"] rescue nil
      aecs_unload.remarks = value["remarks"].squish rescue nil
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

  def self.get_average_detention(detention, rake_count)
     
    detn = detention.split(":")
    hour = detn[0].to_i
    minute = detn[1].to_i
    avg_hour = (hour/rake_count).to_i
    if (hour-(avg_hour*rake_count)+ minute) != 0
      avg_minute = ((((hour-(avg_hour*rake_count))*60)+minute)/rake_count).to_i
    else
      avg_minute = 0
    end
    average_detention = avg_hour.to_s+ ":"+ avg_minute.to_s
  end 

  def self.get_phasewise_data(temp)
    phasewise_data= {}
    phasewise_loaded_unit =0
    phasewise_rake_count = 0
    total_detn_ar_pl = []
    total_detn_pm_rl = []
    total_detn_rl_rm = []
    total_detn_rm_dp = []
    total_detn_rl_rm_dp = []
    total_detn_ar_dp = []

      temp.each do |key,value|
   
        rake_count = value.map{|x| x.rake_count || 0.0}.sum
        loaded_unit = value.map{|x|x.loaded_unit || 0}.sum
        #sum_strings gem used to calculate detention
         
        detention_arrival_placement = value.map{|x|x.detention_arrival_placement}.reject(&:blank?).sum_strings(':')
        detention_placement_release = value.map{|x|x.detention_placement_release}.reject(&:blank?).sum_strings(':')
        detention_removal_departure = value.map{|x|x.detention_removal_departure}.reject(&:blank?).sum_strings(':') 
        detention_release_removal = value.map{|x|x.detention_release_removal}.reject(&:blank?).sum_strings(':')
        detention_release_removal_departure = value.map{|x| [x.detention_release_removal,x.detention_removal_departure]}.flatten.delete_if {|x| x == "NA" }.reject(&:blank?).sum_strings(':')
        detention_arrival_departure = [detention_arrival_placement,detention_placement_release,detention_release_removal].delete_if {|x| x == "NA" }.flatten.reject(&:blank?).sum_strings(':')

        detention_arrival_placement_average = detention_arrival_placement.present? ? RakeUnload.get_average_detention(detention_arrival_placement,rake_count) : ""
        detention_placement_release_average = detention_placement_release.present? ? RakeUnload.get_average_detention(detention_placement_release,rake_count) : ""
        detention_release_removal_average = detention_release_removal.present? ? RakeUnload.get_average_detention(detention_release_removal,rake_count) : ""
        detention_removal_departure_average = detention_removal_departure.present? ? RakeUnload.get_average_detention(detention_removal_departure,rake_count) : ""
        detention_release_removal_departure_average = detention_release_removal_departure.present? ? RakeUnload.get_average_detention(detention_release_removal_departure,rake_count) : ""
        detention_arrival_departure_average = [detention_arrival_placement_average,detention_placement_release_average,detention_release_removal_average].delete_if {|x| x == "NA" }.flatten.reject(&:blank?).sum_strings(':')

        phasewise_loaded_unit +=loaded_unit  
        phasewise_rake_count +=rake_count
        
        total_detn_ar_pl << detention_arrival_placement
        total_detn_pm_rl << detention_placement_release
        total_detn_rl_rm << detention_release_removal
        total_detn_rm_dp << detention_removal_departure
        total_detn_rl_rm_dp << detention_release_removal_departure
        total_detn_ar_dp << detention_arrival_departure
        
       
        phasewise_data[key] = {rake_count: rake_count,loaded_unit: loaded_unit, detention_arrival_placement: detention_arrival_placement, detention_placement_release: detention_placement_release,detention_release_removal: detention_release_removal, detention_removal_departure: detention_removal_departure , detention_release_removal_departure: detention_release_removal_departure,detention_arrival_departure:detention_arrival_departure,detention_placement_release_average: detention_placement_release_average, detention_arrival_placement_average: detention_arrival_placement_average,detention_release_removal_average: detention_release_removal_average, detention_removal_departure_average: detention_removal_departure_average, detention_release_removal_departure_average: detention_release_removal_departure_average, detention_arrival_departure_average: detention_arrival_departure_average}
      end

        total_detn_arrival_placement = total_detn_ar_pl.reject(&:blank?).sum_strings(':')
        total_detn_placement_release  = total_detn_pm_rl.reject(&:blank?).sum_strings(':')
        total_detn_release_removal = total_detn_rl_rm.reject(&:blank?).sum_strings(':')
        total_detn_removal_departure  = total_detn_rm_dp.reject(&:blank?).sum_strings(':')
        total_detn_release_removal_departure = total_detn_rl_rm_dp.reject(&:blank?).sum_strings(':')
        total_detn_arrival_departure = [total_detn_arrival_placement,total_detn_placement_release,total_detn_release_removal].delete_if {|x| x == "NA" }.flatten.reject(&:blank?).sum_strings(':')

        total_average_arrival_placement  = total_detn_arrival_placement.present? ? RakeUnload.get_average_detention(total_detn_arrival_placement, phasewise_rake_count) : ""
        total_average_placement_release  = total_detn_placement_release.present? ? RakeUnload.get_average_detention(total_detn_placement_release, phasewise_rake_count) : ""
        total_average_release_removal  = total_detn_release_removal.present? ? RakeUnload.get_average_detention(total_detn_release_removal, phasewise_rake_count) : ""
        total_average_removal_departure  = total_detn_removal_departure.present? ? RakeUnload.get_average_detention(total_detn_removal_departure, phasewise_rake_count) : ""
        total_average_release_removal_departure = total_detn_release_removal_departure.present? ? RakeUnload.get_average_detention(total_detn_release_removal_departure, phasewise_rake_count) : ""
        total_average_arrival_departure = [total_average_arrival_placement,total_average_placement_release,total_average_release_removal].delete_if {|x| x == "NA" }.flatten.reject(&:blank?).sum_strings(':')

        phasewise_data["Total"] ={phasewise_loaded_unit: phasewise_loaded_unit, phasewise_rake_count: phasewise_rake_count, total_detn_arrival_placement: total_detn_arrival_placement, total_detn_placement_release: total_detn_placement_release,total_detn_release_removal: total_detn_release_removal, total_detn_removal_departure: total_detn_removal_departure, total_detn_release_removal_departure: total_detn_release_removal_departure, total_detn_arrival_departure: total_detn_arrival_departure, total_average_arrival_placement: total_average_arrival_placement, total_average_placement_release: total_average_placement_release,total_average_release_removal: total_average_release_removal, total_average_removal_departure: total_average_removal_departure, total_average_release_removal_departure: total_average_release_removal_departure, total_average_arrival_departure: total_average_arrival_departure}
      
      return(phasewise_data)
         
  end

  def self.get_powerhouse_phasewise_data(data)
    domestic_rakes = []
    domestic_units = []
    domestic_tor = []
    domestic_pm_rl = []
    domestic_pd_pa = []
    domestic_pa_dp = []
    domestic_rl_dp = []
    domestic_in_out = []
    domestic_ger_to_ger_trns = []
    domestic_ger_to_ger_tor = []
    domestic_cc = []
    domestic_pre = []
    domestic_ee = []

    imported_rakes = []
    imported_units = []
    imported_tor = []
    imported_pm_rl = []
    imported_pd_pa = []
    imported_pa_dp = []
    imported_rl_dp = []
    imported_in_out = []
    imported_ger_to_ger_trns = []
    imported_ger_to_ger_tor = []
    imported_cc = []
    imported_pre = []
    imported_ee = []

    powerhouse_data = {}
    data.each do |data|
      if data.commodity_type == "DOMESTIC"
        domestic_rakes << data.rake_count
        domestic_units << data.loaded_unit
        domestic_tor << data.train_on_run_hours
        domestic_pm_rl << data.detention_placement_release
        domestic_pd_pa << data.detention_for_power
        domestic_pa_dp << data.powerarrival_train_departure
        domestic_rl_dp << data.detention_release_removal
        domestic_in_out << data.detention_in_out
        if data.bpc_type == "CC30" || data.bpc_type == "CC35" 
          domestic_cc << data.bpc_type
        elsif  data.bpc_type == "PRE"   
          domestic_pre << data.bpc_type
        else
          domestic_ee << data.bpc_type
        end
        if data.takenover_point == "GER" && data.handedover_point == "GER" 
          domestic_ger_to_ger_trns << data.rake_count
          domestic_ger_to_ger_tor << data.detention_ger_to_ger_tor
        end
      else
        imported_rakes << data.rake_count
        imported_units << data.loaded_unit
        imported_tor << data.train_on_run_hours
        imported_pm_rl << data.detention_placement_release
        imported_pd_pa << data.detention_for_power
        imported_pa_dp << data.powerarrival_train_departure
        imported_rl_dp << data.detention_release_removal
        imported_in_out << data.detention_in_out
        if data.bpc_type == "CC30" || data.bpc_type == "CC35" 
          imported_cc << data.bpc_type
        elsif  data.bpc_type == "PRE"   
          imported_pre << data.bpc_type
        else
          imported_ee << data.bpc_type
        end
        if data.takenover_point == "GER" && data.handedover_point == "GER" 
          imported_ger_to_ger_trns << data.rake_count
          imported_ger_to_ger_tor << data.detention_ger_to_ger_tor
        end
      end  
    end

    total_domestic_rakes = domestic_rakes.sum
    total_domestic_units = domestic_units.sum
    detn_domestic_tor = domestic_tor.delete_if{|x| x=="NA"}.reject(&:blank?).sum_strings(":")
    detn_domestic_pm_rl = domestic_pm_rl.delete_if{|x| x=="NA"}.reject(&:blank?).sum_strings(":")
    detn_domestic_pd_pa = domestic_pd_pa.delete_if{|x| x=="NA"}.reject(&:blank?).sum_strings(":")
    detn_domestic_pa_dp = domestic_pa_dp.delete_if{|x| x=="NA"}.reject(&:blank?).sum_strings(":")
    detn_domestic_rl_dp = domestic_rl_dp.delete_if{|x| x=="NA"}.reject(&:blank?).sum_strings(":")
    detn_domestic_in_out = domestic_in_out.delete_if{|x| x=="NA"}.reject(&:blank?).sum_strings(":")
    total_domestic_ger_to_ger_trns = domestic_ger_to_ger_trns.sum
    detn_domestic_ger_to_ger_tor = domestic_ger_to_ger_tor.delete_if{|x| x=="NA"}.reject(&:blank?).sum_strings(":")
    total_domestic_cc = domestic_cc.count
    total_domestic_pre = domestic_pre.count
    total_domestic_ee = domestic_ee.count

    avg_domestic_tor = detn_domestic_tor.present? ? RakeUnload.get_average_detention(detn_domestic_tor, total_domestic_rakes) : ""
    avg_domestic_pm_rl = detn_domestic_pm_rl.present? ? RakeUnload.get_average_detention(detn_domestic_pm_rl, total_domestic_rakes) : ""
    avg_domestic_pd_pa = detn_domestic_pd_pa.present? ? RakeUnload.get_average_detention(detn_domestic_pd_pa, total_domestic_rakes) : ""
    avg_domestic_pa_dp = detn_domestic_pa_dp.present? ? RakeUnload.get_average_detention(detn_domestic_pa_dp, total_domestic_rakes) : ""
    avg_domestic_rl_dp = detn_domestic_rl_dp.present? ? RakeUnload.get_average_detention(detn_domestic_rl_dp, total_domestic_rakes) : ""
    avg_domestic_in_out = detn_domestic_in_out.present? ? RakeUnload.get_average_detention(detn_domestic_in_out, total_domestic_rakes) : ""
    avg_domestic_ger_to_ger_tor = detn_domestic_ger_to_ger_tor.present? ? RakeUnload.get_average_detention(detn_domestic_ger_to_ger_tor, total_domestic_ger_to_ger_trns) : ""

    powerhouse_data["Domestic"] = {rakes: total_domestic_rakes, units: total_domestic_units, detn_tor: detn_domestic_tor, detn_pm_rl: detn_domestic_pm_rl, detn_pd_pa: detn_domestic_pd_pa, detn_pa_dp: detn_domestic_pa_dp, detn_rl_dp: detn_domestic_rl_dp, detn_in_out: detn_domestic_in_out, total_ger_to_ger_trns: total_domestic_ger_to_ger_trns, detn_ger_to_ger_tor: detn_domestic_ger_to_ger_tor, total_cc: total_domestic_cc, total_pre: total_domestic_pre, total_ee: total_domestic_ee, avg_tor: avg_domestic_tor, avg_pm_rl: avg_domestic_pm_rl, avg_pd_pa: avg_domestic_pd_pa, avg_pa_dp: avg_domestic_pa_dp, avg_rl_dp: avg_domestic_rl_dp, avg_in_out: avg_domestic_in_out, avg_ger_to_ger_tor: avg_domestic_ger_to_ger_tor}

    total_imported_rakes = imported_rakes.sum
    total_imported_units = imported_units.sum
    detn_imported_tor = imported_tor.delete_if{|x| x=="NA"}.reject(&:blank?).sum_strings(":")
    detn_imported_pm_rl = imported_pm_rl.delete_if{|x| x=="NA"}.reject(&:blank?).sum_strings(":")
    detn_imported_pd_pa = imported_pd_pa.delete_if{|x| x=="NA"}.reject(&:blank?).sum_strings(":")
    detn_imported_pa_dp = imported_pa_dp.delete_if{|x| x=="NA"}.reject(&:blank?).sum_strings(":")
    detn_imported_rl_dp = imported_rl_dp.delete_if{|x| x=="NA"}.reject(&:blank?).sum_strings(":")
    detn_imported_in_out = imported_in_out.delete_if{|x| x=="NA"}.reject(&:blank?).sum_strings(":")
    total_imported_ger_to_ger_trns = imported_ger_to_ger_trns.sum
    detn_imported_ger_to_ger_tor = imported_ger_to_ger_tor.delete_if{|x| x=="NA"}.reject(&:blank?).sum_strings(":")
    total_imported_cc = imported_cc.count
    total_imported_pre = imported_pre.count
    total_imported_ee = imported_ee.count

    avg_imported_tor = detn_imported_tor.present? ? RakeUnload.get_average_detention(detn_imported_tor, total_imported_rakes) : ""
    avg_imported_pm_rl = detn_imported_pm_rl.present? ? RakeUnload.get_average_detention(detn_imported_pm_rl, total_imported_rakes) : ""
    avg_imported_pd_pa = detn_imported_pd_pa.present? ? RakeUnload.get_average_detention(detn_imported_pd_pa, total_imported_rakes) : ""
    avg_imported_pa_dp = detn_imported_pa_dp.present? ? RakeUnload.get_average_detention(detn_imported_pa_dp, total_imported_rakes) : ""
    avg_imported_rl_dp = detn_imported_rl_dp.present? ? RakeUnload.get_average_detention(detn_imported_rl_dp, total_imported_rakes) : ""
    avg_imported_in_out = detn_imported_in_out.present? ? RakeUnload.get_average_detention(detn_imported_in_out, total_imported_rakes) : ""
    avg_imported_ger_to_ger_tor = detn_imported_ger_to_ger_tor.present? ? RakeUnload.get_average_detention(detn_imported_ger_to_ger_tor, total_imported_ger_to_ger_trns) : ""

    powerhouse_data["Imported"] = {rakes: total_imported_rakes, units: total_imported_units, detn_tor: detn_imported_tor, detn_pm_rl: detn_imported_pm_rl, detn_pd_pa: detn_imported_pd_pa, detn_pa_dp: detn_imported_pa_dp, detn_rl_dp: detn_imported_rl_dp, detn_in_out: detn_imported_in_out, total_ger_to_ger_trns: total_imported_ger_to_ger_trns, detn_ger_to_ger_tor: detn_imported_ger_to_ger_tor, total_cc: total_imported_cc, total_pre: total_imported_pre, total_ee: total_imported_ee, avg_tor: avg_imported_tor, avg_pm_rl: avg_imported_pm_rl, avg_pd_pa: avg_imported_pd_pa, avg_pa_dp: avg_imported_pa_dp, avg_rl_dp: avg_imported_rl_dp, avg_in_out: avg_imported_in_out, avg_ger_to_ger_tor: avg_imported_ger_to_ger_tor}
    
    total_rakes = total_domestic_rakes + total_imported_rakes
    total_units = total_domestic_units + total_imported_units
    detn_tor = [detn_domestic_tor,detn_imported_tor].reject(&:blank?).sum_strings(":")
    detn_pm_rl = [detn_domestic_pm_rl,detn_imported_pm_rl].reject(&:blank?).sum_strings(":")
    detn_pd_pa = [detn_domestic_pd_pa,detn_imported_pd_pa].reject(&:blank?).sum_strings(":")
    detn_pa_dp = [detn_domestic_pa_dp,detn_imported_pa_dp].reject(&:blank?).sum_strings(":")
    detn_rl_dp = [detn_domestic_rl_dp,detn_imported_rl_dp].reject(&:blank?).sum_strings(":")
    detn_in_out = [detn_domestic_in_out,detn_imported_in_out].reject(&:blank?).sum_strings(":")
    total_ger_to_ger_trns = total_domestic_ger_to_ger_trns + total_imported_ger_to_ger_trns
    detn_ger_to_ger_tor = [detn_domestic_ger_to_ger_tor,detn_imported_ger_to_ger_tor].reject(&:blank?).sum_strings(":")
    total_cc = total_domestic_cc + total_imported_cc
    total_pre = total_domestic_pre + total_imported_pre
    total_ee = total_domestic_ee + total_imported_ee
    
    avg_tor = detn_tor.present? ? RakeUnload.get_average_detention(detn_tor, total_rakes) : ""
    avg_pm_rl = detn_pm_rl.present? ? RakeUnload.get_average_detention(detn_pm_rl, total_rakes) : ""
    avg_pd_pa = detn_pd_pa.present? ? RakeUnload.get_average_detention(detn_pd_pa, total_rakes) : ""
    avg_pa_dp = detn_pa_dp.present? ? RakeUnload.get_average_detention(detn_pa_dp, total_rakes) : ""
    avg_rl_dp = detn_rl_dp.present? ? RakeUnload.get_average_detention(detn_rl_dp, total_rakes) : ""
    avg_in_out = detn_in_out.present? ? RakeUnload.get_average_detention(detn_in_out, total_rakes) : ""
    avg_ger_to_ger_tor = detn_ger_to_ger_tor.present? ? RakeUnload.get_average_detention(detn_ger_to_ger_tor, total_ger_to_ger_trns) : ""

    powerhouse_data["Total"] = {rakes: total_rakes, units: total_units, detn_tor: detn_tor, detn_pm_rl: detn_pm_rl, detn_pd_pa: detn_pd_pa, detn_pa_dp: detn_pa_dp, detn_rl_dp: detn_rl_dp, detn_in_out: detn_in_out, total_ger_to_ger_trns: total_ger_to_ger_trns, detn_ger_to_ger_tor: detn_ger_to_ger_tor, total_cc: total_cc, total_pre: total_pre, total_ee: total_ee, avg_tor: avg_tor, avg_pm_rl: avg_pm_rl, avg_pd_pa: avg_pd_pa, avg_pa_dp: avg_pa_dp, avg_rl_dp: avg_rl_dp, avg_in_out: avg_in_out, avg_ger_to_ger_tor: avg_ger_to_ger_tor}
    return(powerhouse_data)  
  end 

  



end
