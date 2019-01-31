class Admin::OneLoadingReportsController < ApplicationController
	layout "admin/application"

	def index
		from_date = params[:from_date].to_date if params[:from_date].present?
		to_date = params[:to_date].to_date if params[:to_date].present?
		
		from_date = Date.today if from_date.blank?
		to_date = Date.today if to_date.blank?
				
		adi_area = Area.find_by(area_code: "ADI")
	 	gimb_area = Area.find_by(area_code: "GIMB")
	 	adi_load_unload = LoadUnload.where(area_id: adi_area.id)
	 	gimb_load_unload = LoadUnload.where(area_id: gimb_area.id)

	 	
		rake_load_data = RakeLoad.where(release_date: from_date..to_date)

	 	rake_load_adi = adi_load_unload.map{|load| load.rake_loads.map{|rake| rake if rake_load_data.include?(rake)}}.flatten.compact
 		rake_load_gimb = gimb_load_unload.map{|load| load.rake_loads.map{|rake| rake if rake_load_data.include?(rake)}}.flatten.compact
		
 		
 		#Stationwise ADI Loading Start
		adi_data_hash = RakeLoad.get_stationwise_loading(rake_load_adi)
		@adi_rake_load_stationwise = adi_data_hash.sort.to_h
		@adi_loading_header = @adi_rake_load_stationwise.map{|k,v|v.keys}.flatten.compact.uniq.sort
		#Stationwise ADI Loading Ends

		#Stationwise GIMB Loading Start
		gimb_data_hash = RakeLoad.get_stationwise_loading(rake_load_gimb)
		@gimb_rake_load_stationwise = gimb_data_hash.sort.to_h
		@gimb_loading_header = @gimb_rake_load_stationwise.map{|k,v|v.keys}.flatten.compact.uniq.sort
		
		#Stationwise GIMB Loading Ends

		#Stockwise ADI Loading Start
		adi_stock_data_hash = RakeLoad.get_stockwise_loading(rake_load_adi)
		@adi_rake_load_stockwise = adi_stock_data_hash.sort.to_h
		@adi_stockwise_header = @adi_rake_load_stockwise.map{|k,v|v.keys}.flatten.compact.uniq.sort
		#Stockwise ADI Loading Ends

		#Stockwise GIMB Loading Start
		gimb_stock_data_hash = RakeLoad.get_stockwise_loading(rake_load_gimb)
		@gimb_rake_load_stockwise = gimb_stock_data_hash.sort.to_h
		@gimb_stockwise_header = @gimb_rake_load_stockwise.map{|k,v|v.keys}.flatten.compact.uniq.sort
		#Stockwise GIMB Loading Ends

		#Stockwise Division Loading Start
		division_stock_data_hash = RakeLoad.get_stockwise_loading(rake_load_data)
		@division_rake_load_stockwise = division_stock_data_hash.sort.to_h
		@division_stockwise_header = @division_rake_load_stockwise.map{|k,v|v.keys}.flatten.compact.uniq.sort
		#Stockwise Division Loading Ends

		#Commodity ADI Loading Start
		adi_commodity_data_hash = RakeLoad.get_commodity_loading(rake_load_adi)
		@adi_rake_load_commodity = adi_commodity_data_hash.sort.to_h
		@adi_commodity_header = @adi_rake_load_commodity.map{|k,v|v.keys}.flatten.compact.uniq.sort
		#Commodity ADI Loading Ends

		#Commodity GIMB Loading Start
		gimb_commodity_data_hash = RakeLoad.get_commodity_loading(rake_load_gimb)
		@gimb_rake_load_commodity = gimb_commodity_data_hash.sort.to_h
		@gimb_commodity_header = @gimb_rake_load_commodity.map{|k,v|v.keys}.flatten.compact.uniq.sort
		#Commodity GIMB Loading Ends

		#Commodity Division Loading Start
		division_commodity_data_hash = RakeLoad.get_commodity_loading(rake_load_data)
		@division_rake_load_commodity = division_commodity_data_hash.sort.to_h
		@division_commodity_header = @division_rake_load_commodity.map{|k,v|v.keys}.flatten.compact.uniq.sort
		#Commodity Division Loading Ends

		#Rake-Station-Commodity-Loading & Loaded-Unit-Station-Commodity-Loading Start
		adi_station_commodity_data_hash = RakeLoad.get_station_commodity_rake_load(rake_load_adi)
		gimb_station_commodity_data_hash = RakeLoad.get_station_commodity_rake_load(rake_load_gimb)
		@adi_station_commodity_rake = adi_station_commodity_data_hash.sort.to_h
		@gimb_station_commodity_rake = gimb_station_commodity_data_hash.sort.to_h
		@adi_station_commodity_header = @adi_station_commodity_rake.map{|k,v|v.keys}.flatten.compact.uniq.sort
		@gimb_station_commodity_header = @gimb_station_commodity_rake.map{|k,v|v.keys}.flatten.compact.uniq.sort
		@rake_load_station_commodity_header = (@gimb_station_commodity_header+@adi_station_commodity_header).uniq.sort
		#Rake-Station-Commodity-Loading & Loaded-Unit-Station-Commodity-Loading Ends

		# GG Loading Details Starts
		gg_major_commodity = MajorCommodity.find_by(major_commodity: "GG")
    @gg_rake_loads = gg_major_commodity.rake_loads.where(release_date: from_date..to_date)
    @gg_rake_loads.map{|load|load.create_rake_loads_rake_commodities.pluck(:rake_commodity_id)}.flatten.compact.uniq
    @create_rake_loads_rake_commoditie_id_hash = {}
    @gg_rake_loads.each do |load|
      load.create_rake_loads_rake_commodities.each do |create_rake_commoditie|
        if @create_rake_loads_rake_commoditie_id_hash[create_rake_commoditie.rake_commodity_id].present?
          rake_unit = create_rake_commoditie.rake_unit rescue 0
        	@create_rake_loads_rake_commoditie_id_hash[create_rake_commoditie.rake_commodity_id].merge!("#{load.id}" => rake_unit)
        else
        	@create_rake_loads_rake_commoditie_id_hash[create_rake_commoditie.rake_commodity_id] = {}
        	rake_unit = create_rake_commoditie.rake_unit rescue 0
        	@create_rake_loads_rake_commoditie_id_hash[create_rake_commoditie.rake_commodity_id].merge!("#{load.id}" => rake_unit)
          # @create_rake_loads_rake_commoditie_id_hash[create_rake_commoditie.rake_commodity_id] = {rake_load_ids: [load.id]}
        end
      end
    end

    @gg_header_hash = {}
    @create_rake_loads_rake_commoditie_id_hash.keys.each do|id|
      rake_commodity = RakeCommodity.find(id) rescue nil
      @gg_header_hash[id] = {code: rake_commodity.rake_commodity_code,name: rake_commodity.rake_commodity_name}
    end
    @create_rake_loads_rake_commoditie_total = []
    @create_rake_loads_rake_commoditie_id_hash.each do|k,v|
    	@create_rake_loads_rake_commoditie_total << [k,v.values.sum]
    end
    # GG Loading Details Ends

    # Salt Loading GIMB Area Starts
    salt_major_commodity = MajorCommodity.find_by(major_commodity: "SALT")
    salt_rake_loads = salt_major_commodity.rake_loads.where(release_date: from_date..to_date)
    @salt_gimb_rake_loads = gimb_load_unload.map{|load| load.rake_loads.map{|rake| rake if salt_rake_loads.include?(rake)}}.flatten.compact
    @salt_gimb_rake_loads.map{|load|load.create_rake_loads_rake_commodities.pluck(:rake_commodity_id)}.flatten.compact.uniq
    @gimb_salt_rake_loads_rake_commoditie_id_hash = {}
    @salt_gimb_rake_loads.each do |load|
      load.create_rake_loads_rake_commodities.each do |create_rake_commoditie|
        if @gimb_salt_rake_loads_rake_commoditie_id_hash[create_rake_commoditie.rake_commodity_id].present?
          rake_unit = create_rake_commoditie.rake_unit rescue 0
        	@gimb_salt_rake_loads_rake_commoditie_id_hash[create_rake_commoditie.rake_commodity_id].merge!("#{load.id}" => rake_unit)
        else
        	@gimb_salt_rake_loads_rake_commoditie_id_hash[create_rake_commoditie.rake_commodity_id] = {}
        	rake_unit = create_rake_commoditie.rake_unit rescue 0
        	@gimb_salt_rake_loads_rake_commoditie_id_hash[create_rake_commoditie.rake_commodity_id].merge!("#{load.id}" => rake_unit)
        end
      end
    end

    @gimb_salt_header_hash = {}
    @gimb_salt_rake_loads_rake_commoditie_id_hash.keys.each do|id|
      rake_commodity = RakeCommodity.find(id) rescue nil
      @gimb_salt_header_hash[id] = {code: rake_commodity.rake_commodity_code,name: rake_commodity.rake_commodity_name}
    end
    @gimb_salt_rake_loads_rake_commoditie_total = []
    @gimb_salt_rake_loads_rake_commoditie_id_hash.each do|k,v|
    	@gimb_salt_rake_loads_rake_commoditie_total << [k,v.values.sum]
    end
    # Salt Loading GIMB Area Ends

    # Fertilizer Loading GIMB Area Starts
    fert_major_commodity = MajorCommodity.find_by(major_commodity: "FERT")
    fert_rake_loads = fert_major_commodity.rake_loads.where(release_date: from_date..to_date)
    @fert_gimb_rake_loads = gimb_load_unload.map{|load| load.rake_loads.map{|rake| rake if fert_rake_loads.include?(rake)}}.flatten.compact
    @fert_gimb_rake_loads.map{|load|load.create_rake_loads_rake_commodities.pluck(:rake_commodity_id)}.flatten.compact.uniq
    @gimb_fert_rake_loads_rake_commoditie_id_hash = {}
    @fert_gimb_rake_loads.each do |load|
      load.create_rake_loads_rake_commodities.each do |create_rake_commoditie|
        if @gimb_fert_rake_loads_rake_commoditie_id_hash[create_rake_commoditie.rake_commodity_id].present?
          rake_unit = create_rake_commoditie.rake_unit rescue 0
        	@gimb_fert_rake_loads_rake_commoditie_id_hash[create_rake_commoditie.rake_commodity_id].merge!("#{load.id}" => rake_unit)
        else
        	@gimb_fert_rake_loads_rake_commoditie_id_hash[create_rake_commoditie.rake_commodity_id] = {}
        	rake_unit = create_rake_commoditie.rake_unit rescue 0
        	@gimb_fert_rake_loads_rake_commoditie_id_hash[create_rake_commoditie.rake_commodity_id].merge!("#{load.id}" => rake_unit)
        end
      end
    end

    @gimb_fert_header_hash = {}
    @gimb_fert_rake_loads_rake_commoditie_id_hash.keys.each do|id|
      rake_commodity = RakeCommodity.find(id) rescue nil
      @gimb_fert_header_hash[id] = {code: rake_commodity.rake_commodity_code,name: rake_commodity.rake_commodity_name}
    end
    @gimb_fert_rake_loads_rake_commoditie_total = []
    @gimb_fert_rake_loads_rake_commoditie_id_hash.each do|k,v|
    	@gimb_fert_rake_loads_rake_commoditie_total << [k,v.values.sum]
    end

   
    # Fertilizer Loading GIMB Area Ends
		
	end

	def show
	end
end
