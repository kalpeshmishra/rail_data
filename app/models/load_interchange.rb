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
    select_interchange_point.each do |ic_point|
      data_hash["received"] = {} if data_hash["received"].blank?
      data_hash["received"]["COVERED"] = {} if data_hash["received"]["COVERED"].blank?
      data_hash["received"]["OPEN"] = {} if data_hash["received"]["OPEN"].blank?
      data_hash["received"]["COVERED"].merge!("#{ic_point}" => {}) if data_hash["received"]["COVERED"][ic_point].blank?
      data_hash["received"]["OPEN"].merge!("#{ic_point}" => {}) if data_hash["received"]["OPEN"][ic_point].blank?
      data_hash["despatch"] = {} if data_hash["despatch"].blank?
      data_hash["despatch"]["COVERED"] = {} if data_hash["despatch"]["COVERED"].blank?
      data_hash["despatch"]["OPEN"] = {} if data_hash["despatch"]["OPEN"].blank?
      data_hash["despatch"]["COVERED"].merge!("#{ic_point}" => {}) if data_hash["despatch"]["COVERED"][ic_point].blank?
      data_hash["despatch"]["OPEN"].merge!("#{ic_point}" => {}) if data_hash["despatch"]["OPEN"][ic_point].blank?
      
      select_wagon_code.each do |wagon,wagon_type|
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
        if cover_open == "COVERED"
          
          if data_hash["received"]["COVERED"][data.interchange_point][wagon_type][data.stock_details].blank?
            data_hash["received"]["COVERED"][data.interchange_point][wagon_type][data.stock_details] = data.rakes
          else
            total = data_hash["received"]["COVERED"][data.interchange_point][wagon_type][data.stock_details]
            total = total + data.rakes
            data_hash["received"]["COVERED"][data.interchange_point][wagon_type][data.stock_details] = total
          end
        elsif cover_open == "OPEN"
          if data_hash["received"]["OPEN"][data.interchange_point][wagon_type][data.stock_details].blank?
            data_hash["received"]["OPEN"][data.interchange_point][wagon_type][data.stock_details] = data.rakes
          else
            total = data_hash["received"]["OPEN"][data.interchange_point][wagon_type][data.stock_details]
            total = total + data.rakes
            data_hash["received"]["OPEN"][data.interchange_point][wagon_type][data.stock_details] = total
          end
        end

      else 
        if cover_open == "COVERED"
         
          if data_hash["despatch"]["COVERED"][data.interchange_point][wagon_type][data.stock_details].blank?
            data_hash["despatch"]["COVERED"][data.interchange_point][wagon_type][data.stock_details] = data.rakes
          else
            total = data_hash["despatch"]["COVERED"][data.interchange_point][wagon_type][data.stock_details]
            total = total + data.rakes
            data_hash["despatch"]["COVERED"][data.interchange_point][wagon_type][data.stock_details] = total
          end
        elsif cover_open == "OPEN"
          if data_hash["despatch"]["OPEN"][data.interchange_point][wagon_type][data.stock_details].blank?
            data_hash["despatch"]["OPEN"][data.interchange_point][wagon_type][data.stock_details] = data.rakes
          else
            total = data_hash["despatch"]["OPEN"][data.interchange_point][wagon_type][data.stock_details]
            total = total + data.rakes
            data_hash["despatch"]["OPEN"][data.interchange_point][wagon_type][data.stock_details] = total
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
        if cover_open == "COVERED"
          if data_hash["received"]["COVERED"][data.interchange_point][wagon_type][data.stock_details].blank?
            data_hash["received"]["COVERED"][data.interchange_point][wagon_type][data.stock_details] = data.units
          else
            total = data_hash["received"]["COVERED"][data.interchange_point][wagon_type][data.stock_details]
            total = total + data.units
            data_hash["received"]["COVERED"][data.interchange_point][wagon_type][data.stock_details] = total
          end
        elsif cover_open == "OPEN"
          if data_hash["received"]["OPEN"][data.interchange_point][wagon_type][data.stock_details].blank?
            data_hash["received"]["OPEN"][data.interchange_point][wagon_type][data.stock_details] = data.units
          else
            total = data_hash["received"]["OPEN"][data.interchange_point][wagon_type][data.stock_details]
            total = total + data.units
            data_hash["received"]["OPEN"][data.interchange_point][wagon_type][data.stock_details] = total
          end
        end

      else 
        if cover_open == "COVERED"
          if data_hash["despatch"]["COVERED"][data.interchange_point][wagon_type][data.stock_details].blank?
            data_hash["despatch"]["COVERED"][data.interchange_point][wagon_type][data.stock_details] = data.units
          else
            total = data_hash["despatch"]["COVERED"][data.interchange_point][wagon_type][data.stock_details]
            total = total + data.units
            data_hash["despatch"]["COVERED"][data.interchange_point][wagon_type][data.stock_details] = total
          end
        elsif cover_open == "OPEN"
          if data_hash["despatch"]["OPEN"][data.interchange_point][wagon_type][data.stock_details].blank?
            data_hash["despatch"]["OPEN"][data.interchange_point][wagon_type][data.stock_details] = data.units
          else
            total = data_hash["despatch"]["OPEN"][data.interchange_point][wagon_type][data.stock_details]
            total = total + data.units
            data_hash["despatch"]["OPEN"][data.interchange_point][wagon_type][data.stock_details] = total
          end
        end
      end
    end
      return(data_hash)
  end

    
  




end