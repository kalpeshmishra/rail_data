class Admin::TwoCustomReportsController < ApplicationController
	layout "admin/application"

	def index
		get_report_data(params)
		
	end

	def get_report_data(params)
		if params[:is_month_filter].present? and params[:selected_months].present?
			months = params[:selected_months].split(",")
			data_hash = {}
			months.each do |month|
			 	month_name = month.upcase
			 	from_date = month.to_date.beginning_of_month 
			 	to_date =	month.to_date.end_of_month
			 	rake_load_data = RakeLoad.where(release_date: from_date..to_date)
				data_hash.merge!("#{month_name}" => [rake_load_data])
			end
			station_list = []
			data_hash.values.each do |data|
			 	data.flatten.each do |value|	
			 		load_unload_code = LoadUnload.find(value.load_unload_id).station.code
			 		station_list << [load_unload_code,value.load_unload_id ]
			 	end
		 	end	
			@two_custom_report_station = station_list.compact.uniq
		end
		
		if params[:is_month_station_filter].present? and params[:selected_stations].present?
			load_unload_ids = params[:selected_stations].split(',').map{|x|x.to_i}.delete_if {|x| x ==0}
			months = params[:selected_months].split(",")
			data_hash = {}
			months.each do |month|
			 	month_name = month.upcase
			 	from_date = month.to_date.beginning_of_month 
			 	to_date =	month.to_date.end_of_month
			 	rake_load_data = RakeLoad.where(release_date: from_date..to_date, load_unload_id: load_unload_ids)
				data_hash.merge!("#{month_name}" => [rake_load_data])
			end
			commodity_list = []
			data_hash.values.each do |data|
			 	data.flatten.each do |value|	
			 		commodity_code = MajorCommodity.find(value.major_commodity.id).major_commodity
			 		commodity_list << [commodity_code,value.major_commodity.id ]
			 	end
		 	end	
			@two_custom_report_station_commodity = commodity_list.compact.uniq
		end
		
		if params[:is_month_data_filter].present? 
			load_unload_ids = params[:selected_stations].split(',').map{|x|x.to_i}.delete_if {|x| x ==0}
			major_commodity_ids = params[:selected_commodity].split(',').map{|x|x.to_i}.delete_if {|x| x ==0}
			months = params[:selected_months].split(",")
			
			data_hash = {}
			months.each do |month|
			 	month_name = month.upcase
			 	from_date = month.to_date.beginning_of_month 
			 	to_date =	month.to_date.end_of_month
			 	rake_load_data = RakeLoad.where(release_date: from_date..to_date, load_unload_id: load_unload_ids, major_commodity_id: major_commodity_ids)
				
				rake_load_data.each do |data|
					load_unload_code = LoadUnload.find(data.load_unload_id).station.code
					if params[:selected_report_type] == "Commodity"
						month_report_type = MajorCommodity.find(data.major_commodity_id).major_commodity
					elsif params[:selected_report_type] == "Destination"
						month_report_type = Station.find(data.station_id).code
					elsif params[:selected_report_type] == "Stock"
						month_report_type = WagonType.find(data.wagon_type_id).wagon_type_code
					elsif params[:selected_report_type] == "Divisionwise"
						month_report_type = Station.find(data.station_id).division.code	
					else params[:selected_report_type] == "Statewise"
						month_report_type = Station.find(data.station_id).state.code	
					end
					if data_hash[load_unload_code].present?
						data_hash[load_unload_code].merge!("#{month_report_type}" => {}) if data_hash[load_unload_code][month_report_type].blank?
						if data_hash[load_unload_code][month_report_type].keys.include?(month)
							data_hash[load_unload_code][month_report_type][month] << data
						else
							data_hash[load_unload_code][month_report_type].merge!("#{month}" => [data])
						end
					else	
						data_hash[load_unload_code] ={}
						data_hash[load_unload_code].merge!("#{month_report_type}" => {})
						if data_hash[load_unload_code][month_report_type].keys.include?(month)
							data_hash[load_unload_code][month_report_type][month] << data
						else
							data_hash[load_unload_code][month_report_type].merge!("#{month}" => [data])
						end
					end
				end
				
			end
			@two_custom_month_report_header = months
			@two_custom_month_report_data = data_hash
		end
		if params[:is_year_filter].present? and params[:selected_year].present?
			year = params[:selected_year].split(",")
			data_hash = {}
			year.each do |year|
			 	from_year = "Jan-"+year
			 	to_year = "Dec-"+year
			 	from_date = from_year.to_date.beginning_of_month 
			 	to_date =	to_year.to_date.end_of_month
			 	rake_load_data = RakeLoad.where(release_date: from_date..to_date)
				data_hash.merge!("#{year}" => [rake_load_data])
			end
			
			station_list = []
			data_hash.values.each do |data|
			 	data.flatten.each do |value|	
			 		load_unload_code = LoadUnload.find(value.load_unload_id).station.code
			 		station_list << [load_unload_code,value.load_unload_id ]
			 	end
		 	end	
			@two_custom_report_year_station = station_list.compact.uniq
		end

		if params[:is_year_station_filter].present? and params[:selected_stations].present?
			load_unload_ids = params[:selected_stations].split(',').map{|x|x.to_i}.delete_if {|x| x ==0}
			year = params[:selected_year].split(",")
			data_hash = {}
			year.each do |year|
			 	from_year = "Jan-"+year
			 	to_year = "Dec-"+year
			 	from_date = from_year.to_date.beginning_of_month 
			 	to_date =	to_year.to_date.end_of_month
			 	rake_load_data = RakeLoad.where(release_date: from_date..to_date, load_unload_id: load_unload_ids)
				data_hash.merge!("#{year}" => [rake_load_data])
			end
			
			commodity_list = []
			data_hash.values.each do |data|
			 	data.flatten.each do |value|	
			 		commodity_code = MajorCommodity.find(value.major_commodity.id).major_commodity
			 		commodity_list << [commodity_code,value.major_commodity.id ]
			 	end
		 	end	
			@two_custom_year_station_commodity = commodity_list.compact.uniq
		end

		if params[:is_year_data_filter].present?
			load_unload_ids = params[:selected_stations].split(',').map{|x|x.to_i}.delete_if {|x| x ==0}
			major_commodity_ids = params[:selected_commodity].split(',').map{|x|x.to_i}.delete_if {|x| x ==0}
			year = params[:selected_year].split(",")
			
			data_hash = {}
			year.each do |year|
			 from_year = "Jan-"+year
			 	to_year = "Dec-"+year
			 	from_date = from_year.to_date.beginning_of_month 
			 	to_date =	to_year.to_date.end_of_month
			 	rake_load_data = RakeLoad.where(release_date: from_date..to_date, load_unload_id: load_unload_ids, major_commodity_id: major_commodity_ids)
				
				rake_load_data.each do |data|
					load_unload_code = LoadUnload.find(data.load_unload_id).station.code
					if params[:selected_report_type] == "Commodity"
						year_report_type = MajorCommodity.find(data.major_commodity_id).major_commodity
					elsif params[:selected_report_type] == "Destination"
						year_report_type = Station.find(data.station_id).code
					elsif params[:selected_report_type] == "Stock"
						year_report_type = WagonType.find(data.wagon_type_id).wagon_type_code
					elsif params[:selected_report_type] == "Divisionwise"
						year_report_type = Station.find(data.station_id).division.code	
					else params[:selected_report_type] == "Statewise"
						year_report_type = Station.find(data.station_id).state.code	
					end
					if data_hash[load_unload_code].present?
						data_hash[load_unload_code].merge!("#{year_report_type}" => {}) if data_hash[load_unload_code][year_report_type].blank?
						if data_hash[load_unload_code][year_report_type].keys.include?(year)
							data_hash[load_unload_code][year_report_type][year] << data
						else
							data_hash[load_unload_code][year_report_type].merge!("#{year}" => [data])
						end
					else	
						data_hash[load_unload_code] ={}
						data_hash[load_unload_code].merge!("#{year_report_type}" => {})
						if data_hash[load_unload_code][year_report_type].keys.include?(year)
							data_hash[load_unload_code][year_report_type][year] << data
						else
							data_hash[load_unload_code][year_report_type].merge!("#{year}" => [data])
						end
					end
				end
				
			end
			@two_custom_year_report_header = year
			@two_custom_year_report_data = data_hash
		end
		
	end

end
