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
      load_interchange.interchange_point = params["interchange_point"].split("-").last rescue nil
      load_interchange.wagon_type_id = value["wagon_type"].to_i rescue nil
      load_interchange.stock_details = value["empty_loaded"] rescue nil
      load_interchange.rakes = value["rakes"] rescue nil
      load_interchange.units = value["units"].to_i rescue nil
      load_interchange.save

      
    end
  end  
end
