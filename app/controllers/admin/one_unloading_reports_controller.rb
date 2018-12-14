class Admin::OneUnloadingReportsController < ApplicationController
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

	 	
		rake_unload_data = RakeUnload.where(release_date: from_date..to_date)

	 	rake_unload_adi = adi_load_unload.map{|load| load.rake_unloads.map{|rake| rake if rake_unload_data.include?(rake)}}.flatten.compact
 		rake_unload_gimb = gimb_load_unload.map{|load| load.rake_unloads.map{|rake| rake if rake_unload_data.include?(rake)}}.flatten.compact
		
		rake_unload_received_data = RakeUnload.where(arrival_date: from_date..to_date)

		rake_unload_received_adi = adi_load_unload.map{|load| load.rake_unloads.map{|rake| rake if rake_unload_received_data.include?(rake)}}.flatten.compact
 		rake_unload_received_gimb = gimb_load_unload.map{|load| load.rake_unloads.map{|rake| rake if rake_unload_received_data.include?(rake)}}.flatten.compact

		#Stationwise ADI (PU)-Unloading Start
		adi_data_hash = RakeLoad.get_stationwise_loading(rake_unload_adi)
		@adi_rake_unload_stationwise = adi_data_hash.sort.to_h
		@adi_unloading_header = @adi_rake_unload_stationwise.map{|k,v|v.keys}.flatten.compact.uniq.sort
		
		#Stationwise ADI (PU)-Unloading Ends

		#Stationwise GIMB (PU)-Unloading Start
		gimb_data_hash = RakeLoad.get_stationwise_loading(rake_unload_gimb)
		@gimb_rake_unload_stationwise = gimb_data_hash.sort.to_h
		@gimb_unloading_header = @gimb_rake_unload_stationwise.map{|k,v|v.keys}.flatten.compact.uniq.sort
		
		#Stationwise GIMB (PU)-Unloading Ends

		#Stockwise ADI (PU)-Unloading Start
		adi_stock_data_hash = RakeLoad.get_stockwise_loading(rake_unload_adi)
		@adi_rake_unload_stockwise = adi_stock_data_hash.sort.to_h
		@adi_unload_stockwise_header = @adi_rake_unload_stockwise.map{|k,v|v.keys}.flatten.compact.uniq.sort
		
		#Stockwise ADI (PU)-Unloading Ends

		#Stockwise GIMB (PU)-Unloading Start
		gimb_stock_data_hash = RakeLoad.get_stockwise_loading(rake_unload_gimb)
		@gimb_rake_unload_stockwise = gimb_stock_data_hash.sort.to_h
		@gimb_unload_stockwise_header = @gimb_rake_unload_stockwise.map{|k,v|v.keys}.flatten.compact.uniq.sort
		
		#Stockwise GIMB (PU)-Unloading Ends

		#Stockwise Division (PU)-Unloading Start
		division_stock_data_hash = RakeLoad.get_stockwise_loading(rake_unload_data)
		@division_rake_unload_stockwise = division_stock_data_hash.sort.to_h
		@division_unload_stockwise_header = @division_rake_unload_stockwise.map{|k,v|v.keys}.flatten.compact.uniq.sort
		
		#Stockwise Division (PU)-Unloading Ends

		#Stockwise ADI Received (PU)-Unloading Start
		adi_stock_received_data_hash = RakeLoad.get_received_stockwise_loading(rake_unload_received_adi)
		@adi_rake_unload_received_stockwise = adi_stock_received_data_hash.sort.to_h
		@adi_unload_received_stockwise_header = @adi_rake_unload_received_stockwise.map{|k,v|v.keys}.flatten.compact.uniq.sort
		#Stockwise ADI Received (PU)-Unloading Ends

		#Stockwise GIMB Received (PU)-Unloading Start
		gimb_stock_received_data_hash = RakeLoad.get_received_stockwise_loading(rake_unload_received_gimb)
		@gimb_rake_unload_received_stockwise = gimb_stock_received_data_hash.sort.to_h
		@gimb_unload_received_stockwise_header = @gimb_rake_unload_received_stockwise.map{|k,v|v.keys}.flatten.compact.uniq.sort
		#Stockwise GIMB Received (PU)-Unloading Ends

		#Stockwise Division Received (PU)-Unloading Start
		division_stock_received_data_hash = RakeLoad.get_received_stockwise_loading(rake_unload_received_data)
		@division_rake_unload_received_stockwise = division_stock_received_data_hash.sort.to_h
		@division_unload_received_stockwise_header = @division_rake_unload_received_stockwise.map{|k,v|v.keys}.flatten.compact.uniq.sort
		#Stockwise Division Received (PU)-Unloading Ends

		#Commodity ADI (PU)-Unloading Start
		adi_commodity_data_hash = RakeLoad.get_commodity_loading(rake_unload_adi)
		@adi_rake_unload_commodity = adi_commodity_data_hash.sort.to_h
		@adi_unload_commodity_header = @adi_rake_unload_commodity.map{|k,v|v.keys}.flatten.compact.uniq.sort
		
		#Commodity ADI (PU)-Unloading Ends

		#Commodity GIMB (PU)-Unloading Start
		gimb_commodity_data_hash = RakeLoad.get_commodity_loading(rake_unload_gimb)
		@gimb_rake_unload_commodity = gimb_commodity_data_hash.sort.to_h
		@gimb_unload_commodity_header = @gimb_rake_unload_commodity.map{|k,v|v.keys}.flatten.compact.uniq.sort
		
		#Commodity GIMB (PU)-Unloading Ends

		#Commodity Division (PU)-Unloading Start
		division_commodity_data_hash = RakeLoad.get_commodity_loading(rake_unload_data)
		@division_rake_unload_commodity = division_commodity_data_hash.sort.to_h
		@division_unload_commodity_header = @division_rake_unload_commodity.map{|k,v|v.keys}.flatten.compact.uniq.sort
		
		#Commodity Division (PU)-Unloading Ends
	end


	def show

	end
end
