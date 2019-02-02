class Admin::UnloadingReportsController < ApplicationController
	layout "admin/application"

	def index
		data = params[:data].to_date if params[:data].present?
    data = Date.today if data.blank?
    # binding.pry
    @rake_unloads = RakeUnload.where(RakeUnload.arel_table[:arrival_date].lteq(data).and(RakeUnload.arel_table[:release_date].eq(data)))
    @rake_unloads += RakeUnload.where(RakeUnload.arel_table[:arrival_date].lteq(data).and(RakeUnload.arel_table[:release_date].eq(nil)))
    @rake_unloads += RakeUnload.where(RakeUnload.arel_table[:arrival_date].lteq(data).and(RakeUnload.arel_table[:release_date].eq("")))
    @rake_unloads += RakeUnload.where(RakeUnload.arel_table[:arrival_date].eq(nil).and(RakeUnload.arel_table[:release_date].eq(data)))
    @rake_unloads += RakeUnload.where(RakeUnload.arel_table[:arrival_date].eq(nil).and(RakeUnload.arel_table[:release_date].eq(nil)))
    
    adi_area_unloads =[]
    gimb_area_unloads =[]

    adi_unit = 0
    gimb_unit = 0
    @rake_unloads.each do |rake_unload|
    	rake_area =  rake_unload.load_unload.station.area.area_code rescue nil
    	if rake_area == "ADI"
    		adi_area_unloads << rake_unload
    		adi_unit = adi_unit + rake_unload.loaded_unit
    	elsif rake_area == "GIMB"
    		gimb_area_unloads << rake_unload
    		gimb_unit = gimb_unit + rake_unload.loaded_unit
    	end
    end
    @adi_unloads = adi_area_unloads.sort_by(&:load_unload_id)
    @gimb_unloads = gimb_area_unloads
    
    @total_adi_unloads = adi_unit
		@total_gimb_unloads = gimb_unit
    @total_rake_unloads = adi_unit + gimb_unit 

    get_abc_summary_data(data)
    
  end
  def get_abc_summary_data(data)
    # previous_date = data-1
    previous_stock = RakeUnload.where(RakeUnload.arel_table[:placement_date].lt(data).and(RakeUnload.arel_table[:release_date].gteq(data)))
    previous_stock += RakeUnload.where(RakeUnload.arel_table[:placement_date].lt(data).and(RakeUnload.arel_table[:release_date].eq(nil)))
    previous_stock += RakeUnload.where(RakeUnload.arel_table[:placement_date].lt(data).and(RakeUnload.arel_table[:release_date].eq("")))
    
    received_stock = RakeUnload.where(RakeUnload.arel_table[:placement_date].eq(data))
    release_stock = RakeUnload.where(RakeUnload.arel_table[:release_date].eq(data))

    onhand_stock = RakeUnload.where(RakeUnload.arel_table[:placement_date].lteq(data).and(RakeUnload.arel_table[:release_date].gt(data)))
    onhand_stock += RakeUnload.where(RakeUnload.arel_table[:placement_date].lteq(data).and(RakeUnload.arel_table[:release_date].eq(nil)))
    onhand_stock += RakeUnload.where(RakeUnload.arel_table[:placement_date].lteq(data).and(RakeUnload.arel_table[:release_date].eq("")))
    
    all_stock = previous_stock + received_stock + release_stock + onhand_stock
    adi_stations = []
    gimb_stations = []
    all_stock.each do |rake_unload|
      rake_area =  rake_unload.load_unload.station.area.area_code 
      if rake_area == "ADI"
        adi_stations << rake_unload.load_unload.station.code
      elsif rake_area == "GIMB"
        gimb_stations << rake_unload.load_unload.station.code
      end
    end
    adi_stations = adi_stations.uniq  
    gimb_stations = gimb_stations.uniq

    adi_data_hash = {}
    if adi_stations.present?
      adi_stations.each do|station|
        adi_data_hash[station] ={}
        previous_stock.each do |rake_unload|
          adi_data_hash[station].merge!("previous_stock" => {})
          stock_type = WagonType.find(rake_unload.wagon_type_id).wagon_details_covered_open
          loaded_unit = rake_unload.loaded_unit
          adi_data_hash[station]["previous_stock"].merge!(stock_type => loaded_unit)
        end
      end
        binding.pry
    end
  end

  def show
    
  end
end
