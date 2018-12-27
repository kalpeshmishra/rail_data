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

  def self.get_custom_report_loading(rake_load , odr_selected)
    data_hash = {}
    date_array = []
    rake_load.each do |data|
      release_date = data.release_date.strftime("%d-%m-%Y")
      date_array << release_date
      load_unload_code = LoadUnload.find(data.load_unload_id).station.code
      major_commodity_code = MajorCommodity.find(data.major_commodity_id).major_commodity
      odr_type = data.odr_type
      # binding.pry
      if data.release_date.present? and data_hash[release_date].present?
        load_unload_data = {"load_unload" => [data]}
        data_hash[release_date].merge!("#{load_unload_code}" => load_unload_data) if data_hash[release_date][load_unload_code].blank?
          if data_hash[release_date][load_unload_code].keys.include?(major_commodity_code)
            # data_hash[release_date][load_unload_code][major_commodity_code] << data
            # binding.pry
            if data_hash[release_date][load_unload_code][major_commodity_code].keys.include?(odr_type)
              data_hash[release_date][load_unload_code][major_commodity_code][odr_type] << data
            else
              # binding.pry
              data_hash[release_date][load_unload_code][major_commodity_code].merge!("#{odr_type}" => [data])
            end
          else
            data_hash[release_date][load_unload_code].merge!("#{major_commodity_code}" => [data])
          end
      else
        data_hash[release_date] = {}
        load_unload_data = {"load_unload" => [data]}
        data_hash[release_date].merge!("#{load_unload_code}" => load_unload_data)
        # binding.pry
          if data_hash[release_date][load_unload_code].keys.include?(major_commodity_code)
            # data_hash[release_date][load_unload_code][major_commodity_code] << data
            # binding.pry
            if data_hash[release_date][load_unload_code][major_commodity_code].keys.include?(odr_type)
              data_hash[release_date][load_unload_code][major_commodity_code][odr_type] << data
            else
              # binding.pry
              data_hash[release_date][load_unload_code][major_commodity_code].merge!("#{odr_type}" => [data])
            end
          else
            data_hash[release_date][load_unload_code].merge!("#{major_commodity_code}" => [data])
          end
      end
      # binding.pry
    end
    
    date_array = date_array.uniq
    header_hash = {}
    # binding.pry
    date_array.each do |date|
      data_hash[date].keys.each do |key|
        if header_hash[key].present?
          data = data_hash[date][key].keys.map{|x|x unless x == "load_unload"}.compact.flatten.uniq
          data = header_hash[key][:header] + data
          header_hash[key][:header] = []
          header_hash[key][:header] = data.compact.flatten.uniq
        else
          data = data_hash[date][key].keys.map{|x|x unless x == "load_unload"}.compact.flatten.uniq
          header_hash[key] = {header: data}
        end
      end
    end
    return {data_hash: data_hash,header_hash: header_hash }
  end

  def self.get_stationwise_loading(rake_load)
    data_hash = {}
    rake_load.each do |data|
      release_date = data.release_date.strftime("%d-%m-%Y")
      load_unload_code = LoadUnload.find(data.load_unload_id).station.code

      if data.release_date.present?
        if data_hash[release_date].present?
          if data_hash[release_date].keys.include?(load_unload_code)
            data_hash[release_date][load_unload_code] << data
          else
            data_hash[release_date].merge!("#{load_unload_code}" => [data])
          end
        else
          data_hash[release_date] = {}
          data_hash[release_date].merge!("#{load_unload_code}" => [data])
        end
      end
    end
    return(data_hash)
  end

  def self.get_stockwise_loading(rake_load)
    data_hash = {}
    rake_load.each do |data|
    release_date = data.release_date.strftime("%d-%m-%Y")
    wagon_code = WagonType.find(data.wagon_type_id).wagon_type_code

      if data.release_date.present?
        if data_hash[release_date].present?

         if data_hash[release_date].keys.include?(wagon_code)
           data_hash[release_date][wagon_code] << data
         else
           data_hash[release_date].merge!("#{wagon_code}" => [data])
         end
        else
         data_hash[release_date] = {}
         data_hash[release_date].merge!("#{wagon_code}" => [data])
        end
      end
    end
    return(data_hash)
  end

  def self.get_received_stockwise_loading(rake_load)
    data_hash = {}
    rake_load.each do |data|
    arrival_date = data.arrival_date.strftime("%d-%m-%Y")
    wagon_code = WagonType.find(data.wagon_type_id).wagon_type_code

      if data.arrival_date.present?
        if data_hash[arrival_date].present?

         if data_hash[arrival_date].keys.include?(wagon_code)
           data_hash[arrival_date][wagon_code] << data
         else
           data_hash[arrival_date].merge!("#{wagon_code}" => [data])
         end
        else
         data_hash[arrival_date] = {}
         data_hash[arrival_date].merge!("#{wagon_code}" => [data])
        end
      end
    end
    return(data_hash)
  end

  def self.get_commodity_loading(rake_load)
    data_hash = {}
    rake_load.each do |data|
    release_date = data.release_date.strftime("%d-%m-%Y")
    commodity_code = MajorCommodity.find(data.major_commodity_id).major_commodity

      if data.release_date.present?
        if data_hash[release_date].present?
          if data_hash[release_date].keys.include?(commodity_code)
            data_hash[release_date][commodity_code] << data
          else
            data_hash[release_date].merge!("#{commodity_code}" => [data])
          end
        else
         data_hash[release_date] = {}
         data_hash[release_date].merge!("#{commodity_code}" => [data])
        end
      end
    end
    return(data_hash)
  end

 
  def self.get_station_commodity_rake_load(rake_load)
    data_hash = {}
    rake_load.each do |data|
    release_date = data.release_date.strftime("%d-%m-%Y")
    load_unload_code = LoadUnload.find(data.load_unload_id).station.code
    commodity_code = MajorCommodity.find(data.major_commodity_id).major_commodity
    
      if data.load_unload_id.present?
        if data_hash[load_unload_code].present?
          if data_hash[load_unload_code].keys.include?(commodity_code)
            data_hash[load_unload_code][commodity_code] << data
          else
            data_hash[load_unload_code].merge!("#{commodity_code}" => [data])
          end
        else
          data_hash[load_unload_code] = {}
          data_hash[load_unload_code].merge!("#{commodity_code}" => [data])
        end
      end
    end
    return(data_hash)
  end

  # def self.kalpesh
  #    binding.pry
  #    # -loads.last.create_rake_loads_rake_commodities.last.rake_commodity
  #   gg_major_commodity = MajorCommodity.find_by(major_commodity: "GG")
  #   rake_loads = gg_major_commodity.rake_loads
  #   rake_loads.map{|load|load.create_rake_loads_rake_commodities.pluck(:rake_commodity_id)}.flatten.compact.uniq
  #   create_rake_loads_rake_commoditie_id_hash = {}
  #   rake_loads.each do |load|
  #     load.create_rake_loads_rake_commodities.each do |create_rake_commoditie|
  #       if create_rake_loads_rake_commoditie_id_hash[create_rake_commoditie.rake_commodity_id].present?
  #         create_rake_loads_rake_commoditie_id_hash[create_rake_commoditie.rake_commodity_id][:rake_load_ids] << load.id
  #       else
  #         create_rake_loads_rake_commoditie_id_hash[create_rake_commoditie.rake_commodity_id] = {rake_load_ids: [load.id]}
  #       end
  #     end
  #   end

  #   @gg_header_hash = {}
  #   create_rake_loads_rake_commoditie_id_hash.keys.each do|id|
  #     rake_commodity = RakeCommodity.find(id) rescue nil
  #     @gg_header_hash[id] = {name: rake_commodity.rake_commodity_name}
  #   end
  # end
  
end
