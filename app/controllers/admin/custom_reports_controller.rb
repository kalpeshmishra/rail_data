class Admin::CustomReportsController < ApplicationController
  layout "admin/application"
  def index
    from_date = params[:from_date].to_date if params[:from_date].present?
		to_date = params[:to_date].to_date if params[:to_date].present?
		
		from_date = Date.today if from_date.blank?
		to_date = Date.today if to_date.blank?

		station_list = []
		commodity_list = []
		rake_load_data = RakeLoad.where(release_date: from_date..to_date)
		rake_load_data.each do |rake_load|
			station_list << [rake_load.load_unload.station.code,rake_load.load_unload_id ]
			commodity_list << [rake_load.major_commodity.major_commodity, rake_load.major_commodity.id]
		end
		@custom_station_list = station_list.compact.uniq 
		@custom_commodity_list = commodity_list.compact.uniq.sort
			
		if params[:is_station_filter].present? and params[:selected_stations].present?
     	load_and_unload_ids = params[:selected_stations].split(',').map{|x|x.to_i}.delete_if {|x| x ==0}
     	# @custom_station_commodity_list = load_and_unload_ids.map{|load_unload_id| MajorCommodity.find(rake_load_data.find_by(load_unload_id: load_unload_id).major_commodity_id) rescue nil}
      @custom_station_commodity_list = load_and_unload_ids.uniq.map{|load_unload_id| MajorCommodity.find(rake_load_data.where(load_unload_id: load_unload_id).map{|maj_comm|maj_comm.major_commodity_id}) rescue nil}.flatten
      @custom_station_commodity_list = @custom_station_commodity_list.map{|x| [x.major_commodity,x.id]}.uniq
		  
    end

		if params[:is_data_filter].present?
			load_unload_ids = params[:selected_stations].split(',').map{|x|x.to_i}.delete_if {|x| x ==0}
			major_commodity_ids = params[:selected_commodity].split(',').map{|x|x.to_i}.delete_if {|x| x ==0}
			custom_rake_load_data = rake_load_data.where(load_unload_id: load_unload_ids,major_commodity_id: major_commodity_ids)
			
			custom_data_hash = RakeLoad.get_custom_report_loading(custom_rake_load_data)
      @custom_report_data_hash = custom_data_hash[:data_hash]
      @custom_report_header_hash = custom_data_hash[:header_hash]
			
			
		end

  end

  def show
    
  end
end
