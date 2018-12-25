class Admin::OneCustomReportsController < ApplicationController
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
			commodity_list << [rake_load.major_commodity.major_commodity, rake_load.major_commodity.id]
		end
		@one_custom_commodity_list = commodity_list.compact.uniq.sort

		if params[:is_data_filter].present?
			# major_commodity_ids = params[:selected_commodity].split(',').map{|x|x.to_i}.delete_if {|x| x ==0}
			# major_commodity_codes = major_commodity_ids.map{|x| MajorCommodity.find(x).major_commodity}
			if params[:selected_commodity].split(',').include?("multiselect-all")
				major_commodity_codes = ["SALT", "SODA", "FERT", "CONT", "CEMT", "BPOW", "COAL", "GAS", "RMC", "FG"] 
			else
				major_commodity_codes = params[:selected_commodity].split(',')
			end			
			
			major_commodity_codes_with_id = []
			major_commodity_codes.each do |label|
				major = MajorCommodity.find_by(major_commodity: label) rescue nil
				major_commodity_codes_with_id << [label, major.id] if major
			end

			major_commodity_codes_with_id << ["GG",60]

			rake_load_data.map{|x| x.id if x.create_rake_loads_rake_commodities.count > 0}
			total = 0
			data_hash = {}
			
			other = []
			gg = []
			normal = []
			rake_load_data.each do |load|
				major_commodity_id = load.major_commodity_id
				major_commodity = MajorCommodity.find(major_commodity_id) rescue nil
				rake_commodities = major_commodity.rake_commodities if major_commodity.present?
				# 
				if major_commodity.major_commodity != "GG" and load.create_rake_loads_rake_commodities.count > 0
					
					load.create_rake_loads_rake_commodities.each do |commoditie|
						data = RakeCommodity.find(commoditie.rake_commodity_id) rescue nil
						if data.present?
							
							major_data = MajorCommodity.find_by(major_commodity: data.rake_commodity_code)
							
							if major_data.present?
								
								if data_hash[major_data.major_commodity].present?
									final = data_hash[major_data.major_commodity].to_i + commoditie.rake_unit
									data_hash[major_data.major_commodity] = final
								else
									data_hash.merge!("#{major_data.major_commodity}" => commoditie.rake_unit)
								end
								
							else
								
								major_data = MajorCommodity.find_by(id: data.major_commodity_id)
								
								if data_hash[major_data.major_commodity].present?
									final = data_hash[major_data.major_commodity].to_i + commoditie.rake_unit
									data_hash[major_data.major_commodity] = final
								else
									data_hash.merge!("#{major_data.major_commodity}" => commoditie.rake_unit)
								end

								# if data_hash[data.rake_commodity_code].present?
								# 	final = data_hash[data.rake_commodity_code].to_i + commoditie.rake_unit
								# 	data_hash[data.rake_commodity_code] = final
								# else
								# 	data_hash.merge!("#{data.rake_commodity_code}" => commoditie.rake_unit)
								# end
							end	

							normal << data.rake_commodity_code
							puts "===========normal===========> ======#{data.rake_commodity_code}"
						end
					end
					
				elsif major_commodity.major_commodity == "GG" and load.create_rake_loads_rake_commodities.count > 0
					
					load.create_rake_loads_rake_commodities.each do |commoditie|
						data = RakeCommodity.find(commoditie.rake_commodity_id) rescue nil
						if data.present?
							if data_hash[data.rake_commodity_code].present?
								final = data_hash[data.rake_commodity_code].to_i + commoditie.rake_unit
								data_hash[data.rake_commodity_code] = final
							else
								data_hash.merge!("#{data.rake_commodity_code}" => commoditie.rake_unit)
							end

							gg << data.rake_commodity_code
							puts "===========GG===========> ======#{data.rake_commodity_code}"
						end
					end

				else
					loaded_unit = load.loaded_unit
					label = major_commodity.major_commodity
					if label.present? and data_hash[label].present?
						final = data_hash[label].to_i + loaded_unit
					else
						data_hash.merge!("#{label}" => loaded_unit) if label.present?
					end
					puts
					other << label
					puts "===========OTHER===========> ======#{label}"
				end
			end
			
		end

		
	end

	def show
	end


end
