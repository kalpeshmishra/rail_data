class RakeLoad < ApplicationRecord
belongs_to :load_unload
belongs_to :station
belongs_to :major_commodity
belongs_to :wagon_type
has_many :create_rake_loads_rake_commodities

after_save :remove_rake_commodity_breakup
after_destroy :remove_rake_commodity_breakup_data


  def remove_rake_commodity_breakup
    
    old_major_commoidty_id = self.id
    if  self.major_commodity_id != nil and self.major_commodity_id != self.major_commodity_id_was
      old_commodity_breakup = CreateRakeLoadsRakeCommodity.where(rake_load_id: old_major_commoidty_id)
      old_commodity_breakup.destroy_all
      
    end
  end

  def remove_rake_commodity_breakup_data
    old_major_commoidty_id = self.id
    if  self.major_commodity_id != nil
      
      old_commodity_breakup = CreateRakeLoadsRakeCommodity.where(rake_load_id: old_major_commoidty_id)
      old_commodity_breakup.destroy_all
    end 
    
  end


	def self.create_or_update_rake_load(params)
		rake_load_data = {}
    (0..55).map{|no|rake_load_data[no] = {}}
    params.each do |key,value|
      next if ["utf8","authenticity_token"].include?(key)
      no = key.split("_").last.to_i
      new_key = key.split("_")
      new_key.delete(key.split("_").last)
      new_key = new_key.join("_")
      rake_load_data[no].merge!("#{new_key}" => value)

    end

    rake_load_data.each do |key,value|
      data_count = value.values.reject { |c| c.empty? }.count
      next if data_count == 0
      record_id = value["record_id"].to_i if value["record_id"].present?
      rake_load = self.find(record_id) rescue nil if record_id.present?
      rake_load = self.new if rake_load.blank?
      
      from_station = Station.where(code: value["from_station"]).pluck(:id)
      load_unload = LoadUnload.where(station_id: from_station).pluck(:id)
      rake_load.load_unload_id = load_unload[0].to_i rescue nil
      to_station = Station.where(code: value["to_station"]).pluck(:id)
 			rake_load.station_id = to_station[0].to_i rescue nil
      
      
 			rake_load.forecast_date = value["forecast_date"] rescue nil
 			rake_load.rake_received = value["received_as"] rescue nil
      rake_load.major_commodity_id = value["major_commodity"].to_i rescue nil
 			rake_load.wagon_type_id = value["wagon_type"].to_i rescue nil
 			rake_load.loaded_unit = value["loaded_unit"] rescue nil
 			rake_load.total_unit = value["total_unit"] rescue nil
 			rake_load.rake_count = value["rake_count"] rescue nil
      mcommodity = MajorCommodity.where(:id => rake_load.major_commodity_id).pluck(:major_commodity) 
 			if mcommodity == ["CONT"]
        rake_load.stack = value["stack"] rescue nil
        
      else
        rake_load.stack = "" rescue nil
      end
      
      rake_load.odr_type = value["odr_type"] rescue nil
      arrival_time = self.get_time(value["arrival_time"]) 
 			rake_load.arrival_time = arrival_time rescue nil
 			rake_load.arrival_date = value["arrival_date"] rescue nil
      placement_time = get_time(value["placement_time"]) 
 			rake_load.placement_time = placement_time rescue nil
 			rake_load.placement_date = value["placement_date"] rescue nil
      release_time = get_time(value["release_time"])
      rake_load.release_time = release_time rescue nil
 			rake_load.release_date = value["release_date"] rescue nil
      rake_load.detention_arrival_placement = value["detention_arrival_placement"] rescue nil
      rake_load.detention_placement_release = value["detention_placement_release"] rescue nil
      rake_load.short_interchange = value["short_interchange"] rescue nil
      rake_load.short_km = value["short_km"] rescue nil
      rake_load.remark = value["remark"] rescue nil
      rake_load.rakeform_otherform = "R"
      rake_load.save

      
    end
        
	end	

  def RakeLoad.create_or_update_other_load(params)
    other_load_data = {}

    (0..25).map{|no|other_load_data[no] = {}}
    params.each do |key,value|
      next if ["utf8","authenticity_token"].include?(key)
      no = key.split("_").last.to_i
      new_key = key.split("_")
      new_key.delete(key.split("_").last)
      new_key = new_key.join("_")
      other_load_data[no].merge!("#{new_key}" => value)
    end

      other_load_data.each do |key,value|
      data_count = value.values.reject { |c| c.empty? }.count
      next if data_count == 0
      record_id = value["record_id"].to_i if value["record_id"].present?
      other_load = self.find(record_id) rescue nil if record_id.present?
      other_load = self.new if other_load.blank?

      from_station = Station.where(code: value["from_station"]).pluck(:id)
      load_unload = LoadUnload.where(station_id: from_station).pluck(:id)
      other_load.load_unload_id = load_unload[0].to_i rescue nil
      to_station = Station.where(code: value["to_station"]).pluck(:id)
      other_load.station_id = to_station[0].to_i rescue nil

      
      other_load.loaded_unit = value["loaded_unit"] rescue nil
      other_load.rake_count = value["rake_count"] rescue nil
      other_load.major_commodity_id = value["major_commodity"].to_i rescue nil
      other_load.wagon_type_id = value["wagon_type"].to_i rescue nil
      other_load.gross_tons = value["gross_tons"] rescue nil
      other_load.net_tons = value["net_tons"] rescue nil
      other_load.odr_type = value["odr_type"] rescue nil
      other_load.odr_date = value["odr_date"] rescue nil
      release_time = get_time(value["release_time"])
      other_load.release_time = release_time rescue nil
      other_load.release_date = value["release_date"] rescue nil
      other_load.remark = value["remark"] rescue nil
      other_load.rakeform_otherform = "O"
      other_load.save

      
    end
        
  end 

  def self.create_or_update_one_rake_load(params)
    one_rake_load_data = {}
    (0...55).map{|no|one_rake_load_data[no] = {}}
    params.each do |key,value|
      next if ["utf8","authenticity_token"].include?(key)
      no = key.split("_").last.to_i
      new_key = key.split("_")
      new_key.delete(key.split("_").last)
      new_key = new_key.join("_")
      one_rake_load_data[no].merge!("#{new_key}" => value)

    end

    one_rake_load_data.each do |key,value|
      data_count = value.values.reject { |c| c.empty? }.count
      next if data_count == 0
      record_id = value["record_id"].to_i if value["record_id"].present?
      one_rake_load = self.find(record_id) rescue nil if record_id.present?
      one_rake_load = self.new if one_rake_load.blank?
      #commodity break up pending
      one_rake_load.tue_first_row = value["tue_first_row"] rescue nil
      one_rake_load.tue_second_row = value["tue_second_row"] rescue nil
      one_rake_load.powerarrival_time = value["powerarrival_time"] rescue nil
      one_rake_load.powerarrival_date = value["powerarrival_date"] rescue nil
      one_rake_load.departure_time =value["departure_time"] rescue nil
      one_rake_load.departure_date = value["departure_date"] rescue nil
      one_rake_load.detention_release_powerarrival = value["detention_release_powerarrival"] rescue nil
      one_rake_load.detention_powerarrival_departure = value["detention_powerarrival_departure"] rescue nil
      one_rake_load.detention_removal_departure = value["detention_release_departure"] rescue nil
      one_rake_load.power_no = value["power_no"] rescue nil
      one_rake_load.bpc_type = value["bpc_type"] rescue nil
      one_rake_load.bpc_station = value["bpc_station"] rescue nil
      one_rake_load.bpc_date = value["bpc_date"] rescue nil
      one_rake_load.actual_interchange = value["actual_interchange"] rescue nil
      one_rake_load.ic_time = value["ic_time"] rescue nil
      one_rake_load.ic_date = value["ic_date"] rescue nil
      one_rake_load.remark = value["remark"] rescue nil
      one_rake_load.save

      
    end
        
  end

  def self.create_or_update_two_rake_load(params)
    two_rake_load_data = {}
    (0...55).map{|no|two_rake_load_data[no] = {}}
    params.each do |key,value|
      next if ["utf8","authenticity_token"].include?(key)
      no = key.split("_").last.to_i
      new_key = key.split("_")
      new_key.delete(key.split("_").last)
      new_key = new_key.join("_")
      two_rake_load_data[no].merge!("#{new_key}" => value)

    end

    two_rake_load_data.each do |key,value|
      data_count = value.values.reject { |c| c.empty? }.count
      next if data_count == 0
      record_id = value["record_id"].to_i if value["record_id"].present?
      two_rake_load = self.find(record_id) rescue nil if record_id.present?
      two_rake_load = self.new if two_rake_load.blank?
      two_rake_load.gross_tons = value["gross_tons"] rescue nil
      two_rake_load.net_tons = value["net_tons"] rescue nil
      two_rake_load.commodity_type = value["commodity_type"] rescue nil
      two_rake_load.odr_time = value["odr_time"] rescue nil
      two_rake_load.odr_date = value["odr_date"] rescue nil
      two_rake_load.consignor = value["consignor"] rescue nil
      two_rake_load.consignee =value["consignee"] rescue nil
      two_rake_load.remark = value["remark"] rescue nil
      # binding.pry      
      two_rake_load.save

      
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

      temp.each do |key,value|
   
        rake_count = value.map{|x| x.rake_count || 0.0}.sum
        loaded_unit = value.map{|x|x.loaded_unit || 0}.sum
        #sum_strings gem used to calculate detention
        detention_arrival_placement = value.map{|x|x.detention_arrival_placement}.reject(&:blank?).sum_strings(':')
        detention_placement_release = value.map{|x|x.detention_placement_release}.reject(&:blank?).sum_strings(':')
        detention_removal_departure = value.map{|x|x.detention_removal_departure}.reject(&:blank?).sum_strings(':') 
        detention_release_removal = value.map{|x|x.detention_release_removal}.reject(&:blank?).sum_strings(':')
        detention_release_removal_departure = value.map{|x| [x.detention_release_removal,x.detention_removal_departure]}.flatten.reject(&:blank?).sum_strings(':')
        
        detention_arrival_placement_average = detention_arrival_placement.present? ? RakeLoad.get_average_detention(detention_arrival_placement,rake_count) : ""
        detention_placement_release_average = detention_placement_release.present? ? RakeLoad.get_average_detention(detention_placement_release,rake_count) : ""
        detention_release_removal_average = detention_release_removal.present? ? RakeLoad.get_average_detention(detention_release_removal,rake_count) : ""
        detention_removal_departure_average = detention_removal_departure.present? ? RakeLoad.get_average_detention(detention_removal_departure,rake_count) : ""
        detention_release_removal_departure_average = detention_release_removal_departure.present? ? RakeLoad.get_average_detention(detention_release_removal_departure,rake_count) : ""

        phasewise_loaded_unit +=loaded_unit  
        phasewise_rake_count +=rake_count
        
        total_detn_ar_pl << detention_arrival_placement
        total_detn_pm_rl << detention_placement_release
        total_detn_rl_rm << detention_release_removal
        total_detn_rm_dp << detention_removal_departure
        total_detn_rl_rm_dp << detention_release_removal_departure
        
        phasewise_data[key] = {rake_count: rake_count,loaded_unit: loaded_unit, detention_arrival_placement: detention_arrival_placement, detention_placement_release: detention_placement_release,detention_release_removal: detention_release_removal, detention_removal_departure: detention_removal_departure , detention_release_removal_departure: detention_release_removal_departure,detention_placement_release_average: detention_placement_release_average, detention_arrival_placement_average: detention_arrival_placement_average,detention_release_removal_average: detention_release_removal_average, detention_removal_departure_average: detention_removal_departure_average, detention_release_removal_departure_average: detention_release_removal_departure_average}
      end
        total_detn_arrival_placement = total_detn_ar_pl.reject(&:blank?).sum_strings(':')
        total_detn_placement_release  = total_detn_pm_rl.reject(&:blank?).sum_strings(':')
        total_detn_release_removal = total_detn_rl_rm.reject(&:blank?).sum_strings(':')
        total_detn_removal_departure  = total_detn_rm_dp.reject(&:blank?).sum_strings(':')
        total_detn_release_removal_departure = total_detn_rl_rm_dp.reject(&:blank?).sum_strings(':')
        
        total_average_arrival_placement  = total_detn_arrival_placement.present? ? RakeLoad.get_average_detention(total_detn_arrival_placement, phasewise_rake_count) : ""
        total_average_placement_release  = total_detn_placement_release.present? ? RakeLoad.get_average_detention(total_detn_placement_release, phasewise_rake_count) : ""
        total_average_release_removal  = total_detn_release_removal.present? ? RakeLoad.get_average_detention(total_detn_release_removal, phasewise_rake_count) : ""
        total_average_removal_departure  = total_detn_removal_departure.present? ? RakeLoad.get_average_detention(total_detn_removal_departure, phasewise_rake_count) : ""
        total_average_release_removal_departure = total_detn_release_removal_departure.present? ? RakeLoad.get_average_detention(total_detn_release_removal_departure, phasewise_rake_count) : ""

        phasewise_data["Total"] ={phasewise_loaded_unit: phasewise_loaded_unit, phasewise_rake_count: phasewise_rake_count, total_detn_arrival_placement: total_detn_arrival_placement, total_detn_placement_release: total_detn_placement_release,total_detn_release_removal: total_detn_release_removal, total_detn_removal_departure: total_detn_removal_departure, total_detn_release_removal_departure: total_detn_release_removal_departure, total_average_arrival_placement: total_average_arrival_placement, total_average_placement_release: total_average_placement_release,total_average_release_removal: total_average_release_removal, total_average_removal_departure: total_average_removal_departure, total_average_release_removal_departure: total_average_release_removal_departure}
      return(phasewise_data)
         
  end

end
