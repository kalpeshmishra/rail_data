class Admin::OneCustomReportsController < ApplicationController
	layout "admin/application"

	def index
		from_date = params[:from_date].to_date if params[:from_date].present?
		to_date = params[:to_date].to_date if params[:to_date].present?
		
		from_date = Date.today if from_date.blank?
		to_date = Date.today if to_date.blank?

		rake_load_data = RakeLoad.where(release_date: from_date..to_date)

		data_hash = {}
		station_data_hash = {}
		rake_load_data.each do |load|
			major_commodity_id = load.major_commodity_id
			major_commodity = MajorCommodity.find(major_commodity_id) rescue nil
			rake_commodities = major_commodity.rake_commodities if major_commodity.present?
			station_code = load.load_unload.station.code
			# if station_code.present? and station_data_hash[station_code].present?
				#Code for Commodity and LoadedUnit Total Starts
				if load.create_rake_loads_rake_commodities.count == 0
					loaded_unit = load.loaded_unit
					commodity = major_commodity.major_commodity
					if commodity.present? and data_hash[commodity].present?
						final = data_hash[commodity].to_i + loaded_unit
						data_hash[commodity] = final
					else
						data_hash.merge!("#{commodity}" => loaded_unit) if commodity.present?
					end
				elsif major_commodity.major_commodity == "GG" and load.create_rake_loads_rake_commodities.count > 0
					load.create_rake_loads_rake_commodities.each do |gg_load|
						loaded_unit = gg_load.rake_unit
						commodity = RakeCommodity.find(gg_load.rake_commodity_id).rake_commodity_code
						if commodity.present? and data_hash[commodity].present?
							final = data_hash[commodity].to_i + loaded_unit
							data_hash[commodity] = final
						else
							data_hash.merge!("#{commodity}" => loaded_unit) if commodity.present?
						end
					end
				elsif major_commodity.major_commodity == "FG" and load.create_rake_loads_rake_commodities.count > 0
					load.create_rake_loads_rake_commodities.each do |fg_load|
						loaded_unit = fg_load.rake_unit
						commodity = RakeCommodity.find(fg_load.rake_commodity_id).rake_commodity_code
						if commodity.present? and data_hash[commodity].present?
							final = data_hash[commodity].to_i + loaded_unit
							data_hash[commodity] = final
						else
							data_hash.merge!("#{commodity}" => loaded_unit) if commodity.present?
						end
					end
				else
					load.create_rake_loads_rake_commodities.each do |other_load|
					commodity = RakeCommodity.find(other_load.rake_commodity_id).rake_commodity_code
						if MajorCommodity.find_by(major_commodity: commodity).present?
							loaded_unit = other_load.rake_unit
							if commodity.present? and data_hash[commodity].present?
								final = data_hash[commodity].to_i + loaded_unit
								data_hash[commodity] = final
							else
								data_hash.merge!("#{commodity}" => loaded_unit) if commodity.present?
							end
						else
							loaded_unit = other_load.rake_unit
							major_id = RakeCommodity.find(other_load.rake_commodity_id).major_commodity_id
							other_commodity = MajorCommodity.find(major_id).major_commodity
							if other_commodity.present? and data_hash[other_commodity].present?
								final = data_hash[other_commodity].to_i + loaded_unit
								data_hash[other_commodity] = final
							else
								data_hash.merge!("#{other_commodity}" => loaded_unit) if other_commodity.present?
							end
						end
					end
				end
				#Code for Commodity and LoadedUnit Total Ends
			# end

		end
		@one_custom_commodity_list = data_hash.keys.map{|x| [x,x]}
		

		if params[:is_data_filter].present?
			selected_commodity_codes = params[:selected_commodity].split(',').map{|x|x}.delete_if {|x| x =="multiselect-all"}
			
			
		end



	end

	def show
	end


end
