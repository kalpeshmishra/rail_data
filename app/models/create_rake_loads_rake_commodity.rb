class CreateRakeLoadsRakeCommodity < ApplicationRecord
  belongs_to :rake_load
  belongs_to :rake_commodity

  def self.create_rake_loads_rake_commodity(params)
    rake_load = RakeLoad.find(params[:rake_load_id].to_i)
    rake_commodity_hash = {}
    params.each do |key,value|
      next if key.exclude?("select_rake_commodity") 
      rake_commodity = "select_rake_commodity_"+ key.split("_")[3]
      rake_unit = "select_rake_unit_" + key.split("_")[3]
      commodity_rake_count = "commodity_rake_count_" + key.split("_")[3]
      if rake_commodity_hash[key.split("_")[3]].blank?
        rake_commodity_hash[key.split("_")[3]] = {"rake_commodity" => params[rake_commodity],"rake_unit" => params[rake_unit],"commodity_rake_count" => params[commodity_rake_count]}
      end
    end
    
    rake_commodity_hash.each do |key,value|
      rake_commodity_id = value["rake_commodity"].to_i
      rake_unit = value["rake_unit"].to_i
      commodity_rake_count = value["commodity_rake_count"].to_f
      rake_loads_rake_commodity = CreateRakeLoadsRakeCommodity.find_or_initialize_by(rake_load_id: rake_load.id,rake_commodity_id: rake_commodity_id)
      rake_loads_rake_commodity.commodity_rake_count = commodity_rake_count
      rake_loads_rake_commodity.rake_unit = rake_unit
      rake_loads_rake_commodity.save
    end
  end 
end
