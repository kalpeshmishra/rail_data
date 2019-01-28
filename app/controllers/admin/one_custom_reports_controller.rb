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
			station = load.load_unload.station.code
			if load.create_rake_loads_rake_commodities.count == 0
				loaded_unit = load.loaded_unit
				commodity = major_commodity.major_commodity
				if station.present? and data_hash[station].present?
					if commodity.present? and data_hash[station][commodity].present?
						final = data_hash[station][commodity].to_i + loaded_unit
						data_hash[station][commodity] = final
					else
						data_hash[station].merge!("#{commodity}" => loaded_unit) if commodity.present?
					end
				else
						data_hash[station] = {}
						data_hash[station].merge!("#{commodity}" => loaded_unit) 
				end
				
			elsif major_commodity.major_commodity == "GG" and load.create_rake_loads_rake_commodities.count > 0
				load.create_rake_loads_rake_commodities.each do |gg_load|
					loaded_unit = gg_load.rake_unit
					commodity = RakeCommodity.find(gg_load.rake_commodity_id).rake_commodity_code
					if station.present? and data_hash[station].present?
						if commodity.present? and data_hash[station][commodity].present?
							final = data_hash[station][commodity].to_i + loaded_unit
							data_hash[station][commodity] = final
						else
							data_hash[station].merge!("#{commodity}" => loaded_unit) if commodity.present?
						end
					else
							data_hash[station] = {} if data_hash[station].blank?
							data_hash[station].merge!("#{commodity}" => loaded_unit) 
					end
				end
			elsif major_commodity.major_commodity == "FG" and load.create_rake_loads_rake_commodities.count > 0
				load.create_rake_loads_rake_commodities.each do |fg_load|
					loaded_unit = fg_load.rake_unit
					commodity = RakeCommodity.find(fg_load.rake_commodity_id).rake_commodity_code
					if station.present? and data_hash[station].present?
						if commodity.present? and data_hash[station][commodity].present?
							final = data_hash[station][commodity].to_i + loaded_unit
							data_hash[station][commodity] = final
						else
							data_hash[station].merge!("#{commodity}" => loaded_unit) if commodity.present?
						end
					else
							data_hash[station] = {} if data_hash[station].blank?
							data_hash[station].merge!("#{commodity}" => loaded_unit) 
					end
				end
			else
				load.create_rake_loads_rake_commodities.each do |other_load|
				commodity = RakeCommodity.find(other_load.rake_commodity_id).rake_commodity_code
					if MajorCommodity.find_by(major_commodity: commodity).present?
						loaded_unit = other_load.rake_unit
						if station.present? and data_hash[station].present?
							if commodity.present? and data_hash[station][commodity].present?
								final = data_hash[station][commodity].to_i + loaded_unit
								data_hash[station][commodity] = final
							else
								data_hash[station].merge!("#{commodity}" => loaded_unit) if commodity.present?
							end
						else
							data_hash[station] = {}
							data_hash[station].merge!("#{commodity}" => loaded_unit) 
						end
					else
						loaded_unit = other_load.rake_unit
						major_id = RakeCommodity.find(other_load.rake_commodity_id).major_commodity_id
						other_commodity = MajorCommodity.find(major_id).major_commodity
						if station.present? and data_hash[station].present?
							if other_commodity.present? and data_hash[station][other_commodity].present?
								final = data_hash[station][other_commodity].to_i + loaded_unit
								data_hash[station][other_commodity] = final
							else
								# data_hash[station] = {} if data_hash[station].blank?
								data_hash[station].merge!("#{other_commodity}" => loaded_unit) if other_commodity.present?
							end
						else
							data_hash[station] = {}
							data_hash[station].merge!("#{other_commodity}" => loaded_unit)
						end
					end
				end
			end
		end
				
		@one_custom_commodity_list = []
		data_hash.each do |station,data|
			@one_custom_commodity_list <<data.keys
		end
		@one_custom_commodity_list = @one_custom_commodity_list.flatten.compact.uniq
		@one_custom_commodity_list = @one_custom_commodity_list.map{|commodity_code| 
			if MajorCommodity.find_by(major_commodity: commodity_code).present?
				commodity_name = MajorCommodity.find_by(major_commodity: commodity_code).name
				["#{commodity_code}--#{commodity_name}",commodity_code]
			else
				commodity_name = RakeCommodity.find_by(rake_commodity_code: commodity_code).rake_commodity_name
				["#{commodity_code}--#{commodity_name}",commodity_code]
			end
		}
		if params[:is_data_filter].present?
			final_data = {}
			selected_commodities = params[:selected_commodity].split(',').map{|x|x}.delete_if {|x| x =="multiselect-all"}
			@one_custom_commodity_header = selected_commodities
			@one_custom_commodity_header << "Other"
			data_hash.each do |station,value|
				if selected_commodities.include? value.keys[0]
					final_data[station] = {} if final_data[station].blank?
					final_data[station].merge!("#{value.keys[0]}" => value.values[0])
				else
					final_data[station] = {} if final_data[station].blank?
					final_data[station].merge!("Other" => value.values[0])
				end
			end
					# binding.pry  
		end



	end

	def show
	end


end
