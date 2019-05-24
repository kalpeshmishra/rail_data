class LoadInterchange < ApplicationRecord
	belongs_to :wagon_type

	def LoadInterchange.create_or_update_load_interchange(params)
    load_interchange_data = {}
   
    (0..25).map{|no|load_interchange_data[no] = {}}
    params.each do |key,value|
      next if ["utf8","authenticity_token","record_date","interchange_point"].include?(key)
      no = key.split("_").last.to_i
      new_key = key.split("_")
      new_key.delete(key.split("_").last)
      new_key = new_key.join("_")
      load_interchange_data[no].merge!("#{new_key}" => value)
    end
    

    load_interchange_data.each do |key,value|
      data_count = value.values.reject { |c| c.empty? }.count
      next if data_count == 0
      record_id = value["record_id"].to_i if value["record_id"].present?
      load_interchange = self.find(record_id) rescue nil if record_id.present?
      load_interchange = self.new if load_interchange.blank?

    	load_interchange.interchange_date = params["record_date"] rescue nil
      load_interchange.interchange_type = params["interchange_point"].split("-").first rescue nil
      ic_point = params["interchange_point"].split("-").last
      load_interchange.interchange_point = ic_point rescue nil
      if ic_point == "GER" || "VGDC" || "DHG" || "MALB" 
        ic_point_type = "DIVISIONAL"
      elsif ic_point == "PNU" || "BLDI"
        ic_point_type = "ZONAL"
      elsif ic_point == "SIOB" 
        ic_point_type = "INTER-DIVISION"
      end
      load_interchange.interchange_point_type = ic_point_type rescue nil
      load_interchange.wagon_type_id = value["wagon_type"].to_i rescue nil
      load_interchange.stock_details = value["empty_loaded"] rescue nil
      load_interchange.rakes = value["rakes"] rescue nil
      load_interchange.units = value["units"].to_i rescue nil
      load_interchange.save

      
    end
  end

  def self.get_load_interchange_data(interchange_load,select_interchange_point,data_type)
    
    ic_load_data = interchange_load 
    data_hash = {}
    select_wagon_code = ic_load_data.map{|w| [w.wagon_type.wagon_type_code,w.wagon_type.wagon_details_covered_open]}
    select_wagon_code << ["C-Total", "COVERED"]
    select_wagon_code << ["O-Total", "OPEN"]
    select_interchange_point.each do |ic_point|
      data_hash["received"] = {} if data_hash["received"].blank?
      data_hash["received"]["COVERED"] = {} if data_hash["received"]["COVERED"].blank?
      data_hash["received"]["OPEN"] = {} if data_hash["received"]["OPEN"].blank?
      data_hash["received"]["COVERED"].merge!("#{ic_point}" => {}) if data_hash["received"]["COVERED"][ic_point].blank?
      data_hash["received"]["OPEN"].merge!("#{ic_point}" => {}) if data_hash["received"]["OPEN"][ic_point].blank?
      
      data_hash["received"]["R-Total"] = {} if data_hash["received"]["R-Total"].blank?

      data_hash["despatch"] = {} if data_hash["despatch"].blank?
      data_hash["despatch"]["COVERED"] = {} if data_hash["despatch"]["COVERED"].blank?
      data_hash["despatch"]["OPEN"] = {} if data_hash["despatch"]["OPEN"].blank?
      data_hash["despatch"]["COVERED"].merge!("#{ic_point}" => {}) if data_hash["despatch"]["COVERED"][ic_point].blank?
      data_hash["despatch"]["OPEN"].merge!("#{ic_point}" => {}) if data_hash["despatch"]["OPEN"][ic_point].blank?
      
      data_hash["despatch"]["D-Total"] = {} if data_hash["despatch"]["D-Total"].blank?

      select_wagon_code.each do |wagon,wagon_type|
        data_hash["received"]["R-Total"].merge!("#{wagon}" => {})
        data_hash["received"]["R-Total"][wagon].merge!("Loaded" => {})
        data_hash["received"]["R-Total"][wagon].merge!("Empty" => {})
        data_hash["despatch"]["D-Total"].merge!("#{wagon}" => {})
        data_hash["despatch"]["D-Total"][wagon].merge!("Loaded" => {})
        data_hash["despatch"]["D-Total"][wagon].merge!("Empty" => {})
        if wagon_type == "COVERED"
          data_hash["received"]["COVERED"][ic_point].merge!("#{wagon}" => {})
          data_hash["received"]["COVERED"][ic_point][wagon].merge!("Loaded" => {})
          data_hash["received"]["COVERED"][ic_point][wagon].merge!("Empty" => {})

          data_hash["despatch"]["COVERED"][ic_point].merge!("#{wagon}" => {})
          data_hash["despatch"]["COVERED"][ic_point][wagon].merge!("Loaded" => {})
          data_hash["despatch"]["COVERED"][ic_point][wagon].merge!("Empty" => {})
        elsif wagon_type == "OPEN" 
          data_hash["received"]["OPEN"][ic_point].merge!("#{wagon}" => {})
          data_hash["received"]["OPEN"][ic_point][wagon].merge!("Loaded" => {})
          data_hash["received"]["OPEN"][ic_point][wagon].merge!("Empty" => {})

          data_hash["despatch"]["OPEN"][ic_point].merge!("#{wagon}" => {})
          data_hash["despatch"]["OPEN"][ic_point][wagon].merge!("Loaded" => {})
          data_hash["despatch"]["OPEN"][ic_point][wagon].merge!("Empty" => {}) 
        end
      end    
    
    end

    if data_type == "rake"
      final_data = LoadInterchange.get_data_rake_wise(ic_load_data,data_hash)
    elsif data_type == "unit"
      
      final_data = LoadInterchange.get_data_unit_wise(ic_load_data,data_hash)
    end
    return(final_data)
  
  end

  def self.get_data_rake_wise(ic_load_data,data_hash)
    
    ic_load_data.each do |data|
      wagon_type = data.wagon_type.wagon_type_code
      cover_open = data.wagon_type.wagon_details_covered_open
       
      if data.interchange_type == "Ex"

        if data_hash["received"]["R-Total"][wagon_type][data.stock_details].blank?
          data_hash["received"]["R-Total"][wagon_type][data.stock_details] = data.rakes
          if cover_open == "COVERED"
            if data_hash["received"]["R-Total"]["C-Total"][data.stock_details].blank?
              data_hash["received"]["R-Total"]["C-Total"][data.stock_details] = data.rakes
            else
              total = data_hash["received"]["R-Total"]["C-Total"][data.stock_details]
              total = total + data.rakes
              data_hash["received"]["R-Total"]["C-Total"][data.stock_details] = total
            end
          else
            if data_hash["received"]["R-Total"]["O-Total"][data.stock_details].blank?
              data_hash["received"]["R-Total"]["O-Total"][data.stock_details] = data.rakes
            else
              total = data_hash["received"]["R-Total"]["O-Total"][data.stock_details]
              total = total + data.rakes
              data_hash["received"]["R-Total"]["O-Total"][data.stock_details] = total
            end
          end

        else
          total = data_hash["received"]["R-Total"][wagon_type][data.stock_details]
          total = total + data.rakes
          data_hash["received"]["R-Total"][wagon_type][data.stock_details] = total
          if cover_open == "COVERED"
            if data_hash["received"]["R-Total"]["C-Total"][data.stock_details].blank?
              data_hash["received"]["R-Total"]["C-Total"][data.stock_details] = data.rakes
            else
              total = data_hash["received"]["R-Total"]["C-Total"][data.stock_details]
              total = total + data.rakes
              data_hash["received"]["R-Total"]["C-Total"][data.stock_details] = total
            end
          else
            if data_hash["received"]["R-Total"]["O-Total"][data.stock_details].blank?
              data_hash["received"]["R-Total"]["O-Total"][data.stock_details] = data.rakes
            else
              total = data_hash["received"]["R-Total"]["O-Total"][data.stock_details]
              total = total + data.rakes
              data_hash["received"]["R-Total"]["O-Total"][data.stock_details] = total
            end
          end
        end


        if cover_open == "COVERED"
          if data_hash["received"]["COVERED"][data.interchange_point][wagon_type][data.stock_details].blank?
            data_hash["received"]["COVERED"][data.interchange_point][wagon_type][data.stock_details] = data.rakes
            if data_hash["received"]["COVERED"][data.interchange_point]["C-Total"][data.stock_details].blank?
              data_hash["received"]["COVERED"][data.interchange_point]["C-Total"][data.stock_details] = data.rakes
            else
              total = data_hash["received"]["COVERED"][data.interchange_point]["C-Total"][data.stock_details]
              total = total + data.rakes
              data_hash["received"]["COVERED"][data.interchange_point]["C-Total"][data.stock_details] = total
            end
          else
            total = data_hash["received"]["COVERED"][data.interchange_point][wagon_type][data.stock_details]
            total = total + data.rakes
            data_hash["received"]["COVERED"][data.interchange_point][wagon_type][data.stock_details] = total
            if data_hash["received"]["COVERED"][data.interchange_point]["C-Total"][data.stock_details].blank?
              data_hash["received"]["COVERED"][data.interchange_point]["C-Total"][data.stock_details] = data.rakes
            else
              total = data_hash["received"]["COVERED"][data.interchange_point]["C-Total"][data.stock_details]
              total = total + data.rakes
              data_hash["received"]["COVERED"][data.interchange_point]["C-Total"][data.stock_details] = total
            end
          end
          
          
        elsif cover_open == "OPEN"
          if data_hash["received"]["OPEN"][data.interchange_point][wagon_type][data.stock_details].blank?
            data_hash["received"]["OPEN"][data.interchange_point][wagon_type][data.stock_details] = data.rakes
            if data_hash["received"]["OPEN"][data.interchange_point]["O-Total"][data.stock_details].blank?
              data_hash["received"]["OPEN"][data.interchange_point]["O-Total"][data.stock_details] = data.rakes
            else
              total = data_hash["received"]["OPEN"][data.interchange_point]["O-Total"][data.stock_details]
              total = total + data.rakes
              data_hash["received"]["OPEN"][data.interchange_point]["O-Total"][data.stock_details] = total
            end
          else
            total = data_hash["received"]["OPEN"][data.interchange_point][wagon_type][data.stock_details]
            total = total + data.rakes
            data_hash["received"]["OPEN"][data.interchange_point][wagon_type][data.stock_details] = total
            if data_hash["received"]["OPEN"][data.interchange_point]["O-Total"][data.stock_details].blank?
              data_hash["received"]["OPEN"][data.interchange_point]["O-Total"][data.stock_details] = data.rakes
            else
              total = data_hash["received"]["OPEN"][data.interchange_point]["O-Total"][data.stock_details]
              total = total + data.rakes
              data_hash["received"]["OPEN"][data.interchange_point]["O-Total"][data.stock_details] = total
            end
          end
        end

      else 

        if data_hash["despatch"]["D-Total"][wagon_type][data.stock_details].blank?
          data_hash["despatch"]["D-Total"][wagon_type][data.stock_details] = data.rakes
          if cover_open == "COVERED"
            if data_hash["despatch"]["D-Total"]["C-Total"][data.stock_details].blank?
              data_hash["despatch"]["D-Total"]["C-Total"][data.stock_details] = data.rakes
            else
              total = data_hash["despatch"]["D-Total"]["C-Total"][data.stock_details]
              total = total + data.rakes
              data_hash["despatch"]["D-Total"]["C-Total"][data.stock_details] = total
            end
          else
            if data_hash["despatch"]["D-Total"]["O-Total"][data.stock_details].blank?
              data_hash["despatch"]["D-Total"]["O-Total"][data.stock_details] = data.rakes
            else
              total = data_hash["despatch"]["D-Total"]["O-Total"][data.stock_details]
              total = total + data.rakes
              data_hash["despatch"]["D-Total"]["O-Total"][data.stock_details] = total
            end
          end
        else
          total = data_hash["despatch"]["D-Total"][wagon_type][data.stock_details]
          total = total + data.rakes
          data_hash["despatch"]["D-Total"][wagon_type][data.stock_details] = total
          if cover_open == "COVERED"
            if data_hash["despatch"]["D-Total"]["C-Total"][data.stock_details].blank?
              data_hash["despatch"]["D-Total"]["C-Total"][data.stock_details] = data.rakes
            else
              total = data_hash["despatch"]["D-Total"]["C-Total"][data.stock_details]
              total = total + data.rakes
              data_hash["despatch"]["D-Total"]["C-Total"][data.stock_details] = total
            end
          else
            if data_hash["despatch"]["D-Total"]["O-Total"][data.stock_details].blank?
              data_hash["despatch"]["D-Total"]["O-Total"][data.stock_details] = data.rakes
            else
              total = data_hash["despatch"]["D-Total"]["O-Total"][data.stock_details]
              total = total + data.rakes
              data_hash["despatch"]["D-Total"]["O-Total"][data.stock_details] = total
            end
          end
        end

        if cover_open == "COVERED"
          if data_hash["despatch"]["COVERED"][data.interchange_point][wagon_type][data.stock_details].blank?
            data_hash["despatch"]["COVERED"][data.interchange_point][wagon_type][data.stock_details] = data.rakes
            if data_hash["despatch"]["COVERED"][data.interchange_point]["C-Total"][data.stock_details].blank?
              data_hash["despatch"]["COVERED"][data.interchange_point]["C-Total"][data.stock_details] = data.rakes
            else
              total = data_hash["despatch"]["COVERED"][data.interchange_point]["C-Total"][data.stock_details]
              total = total + data.rakes
              data_hash["despatch"]["COVERED"][data.interchange_point]["C-Total"][data.stock_details] = total
            end
          else
            total = data_hash["despatch"]["COVERED"][data.interchange_point][wagon_type][data.stock_details]
            total = total + data.rakes
            data_hash["despatch"]["COVERED"][data.interchange_point][wagon_type][data.stock_details] = total
            if data_hash["despatch"]["COVERED"][data.interchange_point]["C-Total"][data.stock_details].blank?
              data_hash["despatch"]["COVERED"][data.interchange_point]["C-Total"][data.stock_details] = data.rakes
            else
              total = data_hash["despatch"]["COVERED"][data.interchange_point]["C-Total"][data.stock_details]
              total = total + data.rakes
              data_hash["despatch"]["COVERED"][data.interchange_point]["C-Total"][data.stock_details] = total
            end
          end
        elsif cover_open == "OPEN"
          if data_hash["despatch"]["OPEN"][data.interchange_point][wagon_type][data.stock_details].blank?
            data_hash["despatch"]["OPEN"][data.interchange_point][wagon_type][data.stock_details] = data.rakes
            if data_hash["despatch"]["OPEN"][data.interchange_point]["O-Total"][data.stock_details].blank?
              data_hash["despatch"]["OPEN"][data.interchange_point]["O-Total"][data.stock_details] = data.rakes
            else
              total = data_hash["despatch"]["OPEN"][data.interchange_point]["O-Total"][data.stock_details]
              total = total + data.rakes
              data_hash["despatch"]["OPEN"][data.interchange_point]["O-Total"][data.stock_details] = total
            end
          else
            total = data_hash["despatch"]["OPEN"][data.interchange_point][wagon_type][data.stock_details]
            total = total + data.rakes
            data_hash["despatch"]["OPEN"][data.interchange_point][wagon_type][data.stock_details] = total
            if data_hash["despatch"]["OPEN"][data.interchange_point]["O-Total"][data.stock_details].blank?
              data_hash["despatch"]["OPEN"][data.interchange_point]["O-Total"][data.stock_details] = data.rakes
            else
              total = data_hash["despatch"]["OPEN"][data.interchange_point]["O-Total"][data.stock_details]
              total = total + data.rakes
              data_hash["despatch"]["OPEN"][data.interchange_point]["O-Total"][data.stock_details] = total
            end
          end
        end
      end
    end
      return(data_hash)
  end

  def self.get_data_unit_wise(ic_load_data,data_hash)
    ic_load_data.each do |data|
      wagon_type = data.wagon_type.wagon_type_code
      cover_open = data.wagon_type.wagon_details_covered_open
       
      if data.interchange_type == "Ex"

        if data_hash["received"]["R-Total"][wagon_type][data.stock_details].blank?
          data_hash["received"]["R-Total"][wagon_type][data.stock_details] = data.units
          if cover_open == "COVERED"
            if data_hash["received"]["R-Total"]["C-Total"][data.stock_details].blank?
              data_hash["received"]["R-Total"]["C-Total"][data.stock_details] = data.units
            else
              total = data_hash["received"]["R-Total"]["C-Total"][data.stock_details]
              total = total + data.units
              data_hash["received"]["R-Total"]["C-Total"][data.stock_details] = total
            end
          else
            if data_hash["received"]["R-Total"]["O-Total"][data.stock_details].blank?
              data_hash["received"]["R-Total"]["O-Total"][data.stock_details] = data.units
            else
              total = data_hash["received"]["R-Total"]["O-Total"][data.stock_details]
              total = total + data.units
              data_hash["received"]["R-Total"]["O-Total"][data.stock_details] = total
            end
          end

        else
          total = data_hash["received"]["R-Total"][wagon_type][data.stock_details]
          total = total + data.units
          data_hash["received"]["R-Total"][wagon_type][data.stock_details] = total
          if cover_open == "COVERED"
            if data_hash["received"]["R-Total"]["C-Total"][data.stock_details].blank?
              data_hash["received"]["R-Total"]["C-Total"][data.stock_details] = data.units
            else
              total = data_hash["received"]["R-Total"]["C-Total"][data.stock_details]
              total = total + data.units
              data_hash["received"]["R-Total"]["C-Total"][data.stock_details] = total
            end
          else
            if data_hash["received"]["R-Total"]["O-Total"][data.stock_details].blank?
              data_hash["received"]["R-Total"]["O-Total"][data.stock_details] = data.units
            else
              total = data_hash["received"]["R-Total"]["O-Total"][data.stock_details]
              total = total + data.units
              data_hash["received"]["R-Total"]["O-Total"][data.stock_details] = total
            end
          end
        end


        if cover_open == "COVERED"
          if data_hash["received"]["COVERED"][data.interchange_point][wagon_type][data.stock_details].blank?
            data_hash["received"]["COVERED"][data.interchange_point][wagon_type][data.stock_details] = data.units
            if data_hash["received"]["COVERED"][data.interchange_point]["C-Total"][data.stock_details].blank?
              data_hash["received"]["COVERED"][data.interchange_point]["C-Total"][data.stock_details] = data.units
            else
              total = data_hash["received"]["COVERED"][data.interchange_point]["C-Total"][data.stock_details]
              total = total + data.units
              data_hash["received"]["COVERED"][data.interchange_point]["C-Total"][data.stock_details] = total
            end
          else
            total = data_hash["received"]["COVERED"][data.interchange_point][wagon_type][data.stock_details]
            total = total + data.units
            data_hash["received"]["COVERED"][data.interchange_point][wagon_type][data.stock_details] = total
            if data_hash["received"]["COVERED"][data.interchange_point]["C-Total"][data.stock_details].blank?
              data_hash["received"]["COVERED"][data.interchange_point]["C-Total"][data.stock_details] = data.units
            else
              total = data_hash["received"]["COVERED"][data.interchange_point]["C-Total"][data.stock_details]
              total = total + data.units
              data_hash["received"]["COVERED"][data.interchange_point]["C-Total"][data.stock_details] = total
            end
          end
          
          
        elsif cover_open == "OPEN"
          if data_hash["received"]["OPEN"][data.interchange_point][wagon_type][data.stock_details].blank?
            data_hash["received"]["OPEN"][data.interchange_point][wagon_type][data.stock_details] = data.units
            if data_hash["received"]["OPEN"][data.interchange_point]["O-Total"][data.stock_details].blank?
              data_hash["received"]["OPEN"][data.interchange_point]["O-Total"][data.stock_details] = data.units
            else
              total = data_hash["received"]["OPEN"][data.interchange_point]["O-Total"][data.stock_details]
              total = total + data.units
              data_hash["received"]["OPEN"][data.interchange_point]["O-Total"][data.stock_details] = total
            end
          else
            total = data_hash["received"]["OPEN"][data.interchange_point][wagon_type][data.stock_details]
            total = total + data.units
            data_hash["received"]["OPEN"][data.interchange_point][wagon_type][data.stock_details] = total
            if data_hash["received"]["OPEN"][data.interchange_point]["O-Total"][data.stock_details].blank?
              data_hash["received"]["OPEN"][data.interchange_point]["O-Total"][data.stock_details] = data.units
            else
              total = data_hash["received"]["OPEN"][data.interchange_point]["O-Total"][data.stock_details]
              total = total + data.units
              data_hash["received"]["OPEN"][data.interchange_point]["O-Total"][data.stock_details] = total
            end
          end
        end

      else 

        if data_hash["despatch"]["D-Total"][wagon_type][data.stock_details].blank?
          data_hash["despatch"]["D-Total"][wagon_type][data.stock_details] = data.units
          if cover_open == "COVERED"
            if data_hash["despatch"]["D-Total"]["C-Total"][data.stock_details].blank?
              data_hash["despatch"]["D-Total"]["C-Total"][data.stock_details] = data.units
            else
              total = data_hash["despatch"]["D-Total"]["C-Total"][data.stock_details]
              total = total + data.units
              data_hash["despatch"]["D-Total"]["C-Total"][data.stock_details] = total
            end
          else
            if data_hash["despatch"]["D-Total"]["O-Total"][data.stock_details].blank?
              data_hash["despatch"]["D-Total"]["O-Total"][data.stock_details] = data.units
            else
              total = data_hash["despatch"]["D-Total"]["O-Total"][data.stock_details]
              total = total + data.units
              data_hash["despatch"]["D-Total"]["O-Total"][data.stock_details] = total
            end
          end
        else
          total = data_hash["despatch"]["D-Total"][wagon_type][data.stock_details]
          total = total + data.units
          data_hash["despatch"]["D-Total"][wagon_type][data.stock_details] = total
          if cover_open == "COVERED"
            if data_hash["despatch"]["D-Total"]["C-Total"][data.stock_details].blank?
              data_hash["despatch"]["D-Total"]["C-Total"][data.stock_details] = data.units
            else
              total = data_hash["despatch"]["D-Total"]["C-Total"][data.stock_details]
              total = total + data.units
              data_hash["despatch"]["D-Total"]["C-Total"][data.stock_details] = total
            end
          else
            if data_hash["despatch"]["D-Total"]["O-Total"][data.stock_details].blank?
              data_hash["despatch"]["D-Total"]["O-Total"][data.stock_details] = data.units
            else
              total = data_hash["despatch"]["D-Total"]["O-Total"][data.stock_details]
              total = total + data.units
              data_hash["despatch"]["D-Total"]["O-Total"][data.stock_details] = total
            end
          end
        end

        if cover_open == "COVERED"
          if data_hash["despatch"]["COVERED"][data.interchange_point][wagon_type][data.stock_details].blank?
            data_hash["despatch"]["COVERED"][data.interchange_point][wagon_type][data.stock_details] = data.units
            if data_hash["despatch"]["COVERED"][data.interchange_point]["C-Total"][data.stock_details].blank?
              data_hash["despatch"]["COVERED"][data.interchange_point]["C-Total"][data.stock_details] = data.units
            else
              total = data_hash["despatch"]["COVERED"][data.interchange_point]["C-Total"][data.stock_details]
              total = total + data.units
              data_hash["despatch"]["COVERED"][data.interchange_point]["C-Total"][data.stock_details] = total
            end
          else
            total = data_hash["despatch"]["COVERED"][data.interchange_point][wagon_type][data.stock_details]
            total = total + data.units
            data_hash["despatch"]["COVERED"][data.interchange_point][wagon_type][data.stock_details] = total
            if data_hash["despatch"]["COVERED"][data.interchange_point]["C-Total"][data.stock_details].blank?
              data_hash["despatch"]["COVERED"][data.interchange_point]["C-Total"][data.stock_details] = data.units
            else
              total = data_hash["despatch"]["COVERED"][data.interchange_point]["C-Total"][data.stock_details]
              total = total + data.units
              data_hash["despatch"]["COVERED"][data.interchange_point]["C-Total"][data.stock_details] = total
            end
          end
        elsif cover_open == "OPEN"
          if data_hash["despatch"]["OPEN"][data.interchange_point][wagon_type][data.stock_details].blank?
            data_hash["despatch"]["OPEN"][data.interchange_point][wagon_type][data.stock_details] = data.units
            if data_hash["despatch"]["OPEN"][data.interchange_point]["O-Total"][data.stock_details].blank?
              data_hash["despatch"]["OPEN"][data.interchange_point]["O-Total"][data.stock_details] = data.units
            else
              total = data_hash["despatch"]["OPEN"][data.interchange_point]["O-Total"][data.stock_details]
              total = total + data.units
              data_hash["despatch"]["OPEN"][data.interchange_point]["O-Total"][data.stock_details] = total
            end
          else
            total = data_hash["despatch"]["OPEN"][data.interchange_point][wagon_type][data.stock_details]
            total = total + data.units
            data_hash["despatch"]["OPEN"][data.interchange_point][wagon_type][data.stock_details] = total
            if data_hash["despatch"]["OPEN"][data.interchange_point]["O-Total"][data.stock_details].blank?
              data_hash["despatch"]["OPEN"][data.interchange_point]["O-Total"][data.stock_details] = data.units
            else
              total = data_hash["despatch"]["OPEN"][data.interchange_point]["O-Total"][data.stock_details]
              total = total + data.units
              data_hash["despatch"]["OPEN"][data.interchange_point]["O-Total"][data.stock_details] = total
            end
          end
        end
      end
    end
      
      return(data_hash)
  end


  def self.get_summary_load_interchange(select_interchange_load_data)
    temp_data = select_interchange_load_data
    data_hash = {}
    temp_data.each do |data|
      data_hash[data.interchange_point] = {} if data_hash[data.interchange_point].blank?
      if data_hash[data.interchange_point][data.interchange_type].blank? 
        data_hash[data.interchange_point].merge!(data.interchange_type => {"rakes" => [data.rakes], "units" => [data.units]})
      else
        temp_rakes = data_hash[data.interchange_point][data.interchange_type]["rakes"][0]
        temp_rakes = temp_rakes + data.rakes
        data_hash[data.interchange_point][data.interchange_type]["rakes"] = [temp_rakes]
        temp_units = data_hash[data.interchange_point][data.interchange_type]["units"][0]
        temp_units = temp_units + data.units
        data_hash[data.interchange_point][data.interchange_type]["units"] = [temp_units]
      end

    end
    return(data_hash)  
  end

  def self.get_daywise_load_interchange(temp_data)
    data_hash = {}
    temp_data.each do |data|
      ic_date = data.interchange_date.strftime("%d/%m/%Y")
      data_hash[ic_date] = {} if data_hash[ic_date].blank?
      data_hash[ic_date].merge!("Received" => {}, "Despatch" => {}) if data_hash[ic_date].blank?
      if data.interchange_type == "Ex"  # Ex means Received and To means Despatch
        if data_hash[ic_date]["Received"][data.interchange_point].blank?
          data_hash[ic_date]["Received"].merge!(data.interchange_point => {"rakes" => data.rakes, "units" => data.units})
        else  
          data_hash[ic_date]["Received"][data.interchange_point]["rakes"] += data.rakes
          data_hash[ic_date]["Received"][data.interchange_point]["units"] += data.units 
        end
      elsif data.interchange_type == "To" # Ex means Received and To means Despatch
        if data_hash[ic_date]["Despatch"][data.interchange_point].blank?
          data_hash[ic_date]["Despatch"].merge!(data.interchange_point => {"rakes" => data.rakes, "units" => data.units})
        else  
          data_hash[ic_date]["Despatch"][data.interchange_point]["rakes"] += data.rakes
          data_hash[ic_date]["Despatch"][data.interchange_point]["units"] += data.units 
        end                        
      end
    end
    return(data_hash)
      
  end




end