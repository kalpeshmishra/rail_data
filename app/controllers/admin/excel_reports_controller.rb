class Admin::ExcelReportsController < ApplicationController
	layout "admin/application"

	def index
		
	end

	def excel_reports_download #For Reports Downloaded as excel Excel
		require 'roo'
		start_date = params[:from_date]if params[:from_date].present?
		end_date = params[:to_date] if params[:to_date].present?
		
		if params[:report_type] == "LoadingData"
			sheet_name = "LoadingData"
			loading_data = RakeLoad.where(release_date: start_date..end_date)
			statement_xls = Spreadsheet::Workbook.new
	    sheet = statement_xls.create_worksheet :name => sheet_name
	    
	    header = [["Loading Data From:"+start_date+"-To:"+end_date],["SrNo.","Month","Area","From ", "To   ", "ForecastDate", "RakeReceived", "RakeCount", "LoadedUnit", "TotalUnit","Stock", "Commodity", "Stack","Arrival Time/Date", "Placement Time/Date", "Release Time/Date", "Power-Arr Time/Date", "Removal Time/Date", "Departure Time/Date", "Power", "BpcType", "BpcStn", "BpcDate", "Tues 1St", "Tues 2nd", "CommodityType", "ODR-Type", "ODR-Date", "Consignor", "Consignee","Short I/C Point","Short KM" , "Actual I/C Point", "I/C Time/Date", "Detn(AR-PM)", "Detn(PM-RL)", "Detn(RL-PA)", "Detn(PA-DEP)", "Detn(RL-DEP)","Remarks       " ]]
	    sheet.row(0).default_format = Spreadsheet::Format.new(:weight => :bold)
	    sheet.row(1).default_format = Spreadsheet::Format.new(:weight => :bold)
	    row = 0
	    header.each_with_index do |data, i|
	      data.each_with_index do |label, index|
	        sheet[row, index] = label
	        header_width = label.length + 3
	        sheet.column(index).width = header_width
	      end
	      row = row + 1
	    end
	    row_count = 0
	    loading_data.each.with_index(1) do |load_data, index|
	      row_count = index + 1

	      if load_data.arrival_time == ""
	      	load_data.arrival_time = nil
	      end	
	      if load_data.arrival_date == ""
	      	load_data.arrival_date = nil
	      end	
	      if load_data.placement_time == ""
	      	load_data.placement_time = nil
	      end	
	      if load_data.placement_date == ""
	      	load_data.placement_date = nil
	      end	
	      if load_data.release_time == ""
	      	load_data.release_time = nil
	      end	
	      if load_data.release_date == ""
	      	load_data.release_date = nil
	      end	
	      if load_data.powerarrival_time == ""
	      	load_data.powerarrival_time = nil
	      end	
	      if load_data.powerarrival_date == ""
	      	load_data.powerarrival_date = nil
	      end	
	      if load_data.removal_time == ""
	      	load_data.removal_time = nil
	      end	
	      if load_data.removal_date == ""
	      	load_data.removal_date = nil
	      end	
	      if load_data.departure_time == ""
	      	load_data.departure_time = nil
	      end	
	      if load_data.departure_date == ""
	      	load_data.departure_date = nil
	      end	
	      if load_data.ic_time == ""
	      	load_data.ic_time = nil
	      end	
	      if load_data.ic_date == ""
	      	load_data.ic_date = nil					
	      end
	      
	      rake_load_row_values = [index,load_data.release_date&.strftime('%b-%y'),load_data.load_unload.area.area_code,load_data.load_unload.station.code, load_data.station.code, load_data.forecast_date&.strftime('%d-%m-%y'), load_data.rake_received, load_data.rake_count, load_data.loaded_unit, load_data.total_unit, load_data.wagon_type.wagon_type_code, load_data.major_commodity.major_commodity, load_data.stack, (load_data.arrival_time&.first(5)&.concat(" ")&.concat(load_data.arrival_date&.strftime('%d-%m-%y'))),(load_data.placement_time&.first(5)&.concat(" ")&.concat(load_data.placement_date&.strftime('%d-%m-%y'))),(load_data.release_time&.first(5)&.concat(" ")&.concat(load_data.release_date&.strftime('%d-%m-%y'))),(load_data.powerarrival_time&.first(5)&.concat(" ")&.concat(load_data.powerarrival_date&.strftime('%d-%m-%y'))),(load_data.removal_time&.first(5)&.concat(" ")&.concat(load_data.removal_date&.strftime('%d-%m-%y'))),(load_data.departure_time&.first(5)&.concat(" ")&.concat(load_data.departure_date&.strftime('%d-%m-%y'))),load_data.power_no, load_data.bpc_type, load_data.bpc_station, load_data.bpc_date, load_data.tue_first_row, load_data.tue_second_row, load_data.commodity_type, load_data.odr_type, load_data.odr_date, load_data.consignor, load_data.consignee, load_data.short_interchange, load_data.short_km, load_data.actual_interchange,(load_data.ic_time&.first(5)&.concat(" ")&.concat(load_data.ic_date&.strftime('%d-%m-%y'))), load_data.detention_arrival_placement, load_data.detention_placement_release, load_data.detention_release_powerarrival, load_data.detention_powerarrival_departure, load_data.detention_removal_departure, load_data.remark]
	      rake_load_row_values.each_with_index do |content, index|
	        sheet[row_count, index] = content
	      end
	    end
		elsif params[:report_type] == "UnloadingData"
			sheet_name = "UnloadingData"
			unloading_data = RakeUnload.where(release_date: start_date..end_date)
			statement_xls = Spreadsheet::Workbook.new
	    sheet = statement_xls.create_worksheet :name => sheet_name
	    
	    header = [["Unloading(PU) Data From:"+start_date+"-To:"+end_date],["SrNo.","Month","Area","From ", "To   ", "RakeCount", "LoadedUnit", "TotalUnit", "IncomingPower", "Stock", "Stock Desc.", "Commodity", "Stack","Arrival Time/Date", "Placement Time/Date", "Release Time/Date", "Removal Time/Date", "Power-Arr Time/Date", "Departure Time/Date", "Power", "BpcType", "BpcStn", "BpcDate", "Tues 1St", "Tues 2nd", "CommodityType", "Consignor", "Consignee", "Detn(AR-PM)", "Detn(PM-RL)", "Detn(RL-RM)", "Detn(RL-PA)", "Detn(PA-TN.DEP)", "Detn(IN-OUT)" , "Remarks        "]]
	    sheet.row(0).default_format = Spreadsheet::Format.new(:weight => :bold)
	    sheet.row(1).default_format = Spreadsheet::Format.new(:weight => :bold)
	    row = 0
	    header.each_with_index do |data, i|
	      data.each_with_index do |label, index|
	        sheet[row, index] = label
	        header_width = label.length + 3
	        sheet.column(index).width = header_width
	      end
	      row = row + 1
	    end
	    row_count = 0
	    unloading_data.each.with_index(1) do |unload_data, index|
	      row_count = index + 1

	      if unload_data.arrival_time == ""
	      	unload_data.arrival_time = nil
	      end	
	      if unload_data.arrival_date == ""
	      	unload_data.arrival_date = nil
	      end	
	      if unload_data.placement_time == ""
	      	unload_data.placement_time = nil
	      end	
	      if unload_data.placement_date == ""
	      	unload_data.placement_date = nil
	      end	
	      if unload_data.release_time == ""
	      	unload_data.release_time = nil
	      end	
	      if unload_data.release_date == ""
	      	unload_data.release_date = nil
	      end	
	      if unload_data.removal_time == ""
	      	unload_data.removal_time = nil
	      end	
	      if unload_data.removal_date == ""
	      	unload_data.removal_date = nil
	      end	
	      if unload_data.powerarrival_time == ""
	      	unload_data.powerarrival_time = nil
	      end	
	      if unload_data.powerarrival_date == ""
	      	unload_data.powerarrival_date = nil
	      end	
	      if unload_data.departure_time == ""
	      	unload_data.departure_time = nil
	      end	
	      if unload_data.departure_date == ""
	      	unload_data.departure_date = nil
	      end	
	      
	      rake_unload_row_values = [index,unload_data.release_date&.strftime('%b-%y'),unload_data.load_unload.area.area_code, unload_data.station.code, unload_data.load_unload.station.code, unload_data.rake_count, unload_data.loaded_unit, unload_data.total_unit, unload_data.incoming_power, unload_data.wagon_type.wagon_type_code, unload_data.stock_description, unload_data.major_commodity.major_commodity, unload_data.stack, (unload_data.arrival_time&.first(5)&.concat(" ")&.concat(unload_data.arrival_date&.strftime('%d-%m-%y'))),(unload_data.placement_time&.first(5)&.concat(" ")&.concat(unload_data.placement_date&.strftime('%d-%m-%y'))),(unload_data.release_time&.first(5)&.concat(" ")&.concat(unload_data.release_date&.strftime('%d-%m-%y'))),(unload_data.removal_time&.first(5)&.concat(" ")&.concat(unload_data.removal_date&.strftime('%d-%m-%y'))),(unload_data.powerarrival_time&.first(5)&.concat(" ")&.concat(unload_data.powerarrival_date&.strftime('%d-%m-%y'))),(unload_data.departure_time&.first(5)&.concat(" ")&.concat(unload_data.departure_date&.strftime('%d-%m-%y'))),unload_data.power_no, unload_data.bpc_type, unload_data.bpc_station, unload_data.bpc_date, unload_data.tue_first_row, unload_data.tue_second_row, unload_data.commodity_type, unload_data.consignor, unload_data.consignee, unload_data.detention_arrival_placement, unload_data.detention_placement_release, unload_data.detention_release_removal, unload_data.detention_for_power, unload_data.powerarrival_train_departure, unload_data.detention_in_out, unload_data.remarks]
	      rake_unload_row_values.each_with_index do |content, index|
	        sheet[row_count, index] = content
	      end
	    end
		elsif params[:report_type] == "GG-LoadingData"
			sheet_name = "GG-LoadingData"
			gg_major_commodity = MajorCommodity.find_by(major_commodity: "GG")
	    gg_rake_loads = gg_major_commodity.rake_loads.where(release_date: start_date..end_date)
	    gg_load_ids = gg_rake_loads.map{|e| e.id} #not required
	    header_commodity_ids = gg_rake_loads.map{|load|load.create_rake_loads_rake_commodities.pluck(:rake_commodity_id)}.flatten.compact.uniq
	    header_for_loop = [:month, :from, :to, :release, :loaded_unit] + header_commodity_ids
	    header_commodity_name = header_commodity_ids.map{|e| RakeCommodity.find(e).rake_commodity_name}
	    gg_excel_hash = {}
	    temp = {}
	    gg_rake_loads.each do |data|
	    	if data.release_date == ""
	      	data.release_date = nil
	      end	
	    	a = CreateRakeLoadsRakeCommodity.where(rake_load_id: data.id).pluck(:rake_commodity_id,:rake_unit)
	    	b = Hash[*a.flatten(1)]
	    	temp[data.id] = {month: data.release_date&.strftime('%b-%y'), from: data.load_unload.station.code, to: data.station.code,release: (data.release_time&.first(5)&.concat(" ")&.concat(data.release_date&.strftime('%d-%m-%y'))), loaded_unit: data.loaded_unit}
	    	gg_excel_hash[data.id] = temp[data.id].merge(b)
	    	
	    end
	    
	    statement_xls = Spreadsheet::Workbook.new
	    sheet = statement_xls.create_worksheet :name => sheet_name
	    
	    fixed_header = ["SrNo", "Month", "From", "To", "Release Time/Date", "Loaded Unit"]
	    temp_array = fixed_header + header_commodity_name
	    
	    header = [["GG-Loading Data From:"+start_date+"-To:"+end_date],temp_array]
	    sheet.row(0).default_format = Spreadsheet::Format.new(:weight => :bold)
	    sheet.row(1).default_format = Spreadsheet::Format.new(:weight => :bold)
	    row = 0
	    header.each_with_index do |data, i|
	      data.each_with_index do |label, index|
	        sheet[row, index] = label
	        header_width = label.length + 3
	        sheet.column(index).width = header_width
	      end
	      row = row + 1
	    end
	    row_count = 0

	    gg_excel_hash.values.each.with_index(1) do |gg_data, index|
	    	row_count = index + 1
	    	temp_values = []
	    	header_for_loop.each do |header|
	    		temp_values << gg_data[header] 
	    	end	
				gg_load_row_values = [index,temp_values].flatten
				gg_load_row_values.each_with_index do |content, index|
  	      sheet[row_count, index] = content
	      end
    	end
	   
		elsif params[:report_type] == "Powerhouse-Data"
			sheet_name = "PowerhouseData"
			powerhouse_data = RakeUnload.where(release_date: start_date..end_date,form_status: ["GETS","AECS"])
			statement_xls = Spreadsheet::Workbook.new
	    sheet = statement_xls.create_worksheet :name => sheet_name
	    
	    header = [["Powerhouse(PU) Data From:"+start_date+"-To:"+end_date],["SrNo.","Month","Area","From ", "To   ", "TakenOver", "Collary", "Received Time/Date", "RakeCount", "LoadedUnit", "TotalUnit", "IncomingPower", "Stock Type", "Stock Description      ", "Commodity", "CommodityType","Arrival Time/Date", "Placement Time/Date", "Release Time/Date", "Power-Arr Time/Date", "Departure Time/Date", "Power", "HandedOver Time/Date", "Destination", "H/O Point", "BpcType", "BpcStn", "BpcDate", "TOR", "Detn(AR-PM)", "Detn(PM-RL)", "Detn(RL-RM)", "Detn(RL-PA)", "Detn(PA-TN.DEP)", "Detn(IN-OUT)" , "GER To GER (TOR)", "Remarks      "]]
	    sheet.row(0).default_format = Spreadsheet::Format.new(:weight => :bold)
	    sheet.row(1).default_format = Spreadsheet::Format.new(:weight => :bold)
	    row = 0
	    header.each_with_index do |data, i|
	      data.each_with_index do |label, index|
	        sheet[row, index] = label
	        header_width = label.length + 3
	        sheet.column(index).width = header_width
	      end
	      row = row + 1
	    end
	    row_count = 0
	    powerhouse_data.each.with_index(1) do |power_data, index|
	      row_count = index + 1

	      if power_data.takenover_time == ""
	      	power_data.takenover_time = nil
	      end	
	      if power_data.takenover_date == ""
	      	power_data.takenover_date = nil
	      end
	      if power_data.arrival_time == ""
	      	power_data.arrival_time = nil
	      end	
	      if power_data.arrival_date == ""
	      	power_data.arrival_date = nil
	      end	
	      if power_data.placement_time == ""
	      	power_data.placement_time = nil
	      end	
	      if power_data.placement_date == ""
	      	power_data.placement_date = nil
	      end	
	      if power_data.release_time == ""
	      	power_data.release_time = nil
	      end	
	      if power_data.release_date == ""
	      	power_data.release_date = nil
	      end	
	      if power_data.powerarrival_time == ""
	      	power_data.powerarrival_time = nil
	      end	
	      if power_data.powerarrival_date == ""
	      	power_data.powerarrival_date = nil
	      end	
	      if power_data.departure_time == ""
	      	power_data.departure_time = nil
	      end	
	      if power_data.departure_date == ""
	      	power_data.departure_date = nil
	      end	
	      if power_data.handedover_time == ""
	      	power_data.handedover_time = nil
	      end	
	      if power_data.handedover_date == ""
	      	power_data.handedover_date = nil
	      end	
	      
	      powerhouse_unload_row_values = [index,power_data.release_date&.strftime('%b-%y'),power_data.load_unload.area.area_code, power_data.station.code, power_data.load_unload.station.code, power_data.takenover_point, power_data.collary, (power_data.takenover_time&.first(5)&.concat(" ")&.concat(power_data.takenover_date&.strftime('%d-%m-%y'))), power_data.rake_count, power_data.loaded_unit, power_data.total_unit, power_data.incoming_power, power_data.wagon_type.wagon_type_code, power_data.stock_description, power_data.major_commodity.major_commodity, power_data.commodity_type, (power_data.arrival_time&.first(5)&.concat(" ")&.concat(power_data.arrival_date&.strftime('%d-%m-%y'))),(power_data.placement_time&.first(5)&.concat(" ")&.concat(power_data.placement_date&.strftime('%d-%m-%y'))),(power_data.release_time&.first(5)&.concat(" ")&.concat(power_data.release_date&.strftime('%d-%m-%y'))),(power_data.powerarrival_time&.first(5)&.concat(" ")&.concat(power_data.powerarrival_date&.strftime('%d-%m-%y'))),(power_data.departure_time&.first(5)&.concat(" ")&.concat(power_data.departure_date&.strftime('%d-%m-%y'))),power_data.power_no,(power_data.handedover_time&.first(5)&.concat(" ")&.concat(power_data.handedover_date&.strftime('%d-%m-%y'))), power_data.empty_destination, power_data.handedover_point, power_data.bpc_type, power_data.bpc_station, power_data.bpc_date, power_data.train_on_run_hours, power_data.detention_arrival_placement, power_data.detention_placement_release, power_data.detention_release_removal, power_data.detention_for_power, power_data.powerarrival_train_departure, power_data.detention_in_out, power_data.detention_ger_to_ger_tor, power_data.remarks]
	      powerhouse_unload_row_values.each_with_index do |content, index|
	        sheet[row_count, index] = content
	      end
	    end
	  elsif params[:report_type] == "Interchange-Data"
			sheet_name = "Interchange-Data"
			interchange_points = ["GER", "VGDC", "DHG", "MALB", "PNU", "BLDI", "SIOB", "TOTAL"]
			data_type = "rake"
			interchange_load_data = LoadInterchange.where(interchange_date: start_date..end_date)
			rake_load_interchange_hash = LoadInterchange.get_load_interchange_data(interchange_load_data,interchange_points,data_type) if interchange_load_data.present?
			statement_xls = Spreadsheet::Workbook.new
	    sheet = statement_xls.create_worksheet :name => sheet_name
	    h_one = ["STOCK"] + rake_load_interchange_hash.keys.map!(&:upcase)
	    # binding.pry
	    header = [["Interchange Data From:"+start_date+"-To:"+end_date],h_one,interchange_points*2,["SrNo."]]
	    (0..3).each do |i|
	    	sheet.row(i).default_format = Spreadsheet::Format.new(:weight => :bold)
	    end
	    sheet.merge_cells(1,0,2,0)
	    sheet.merge_cells(1,1,1,8)
	    sheet.merge_cells(1,9,1,16)
	    row = 0
	    header.each_with_index do |data, i|
	    	if i == 2
	    		data.prepend("")
	    	end
	    	data.each_with_index do |label, index|
	    		if label == "DESPATCH"
	    			index = 9
	    		end
	    		sheet[row, index] = label
	        header_width = label.length + 3
	        sheet.column(index).width = header_width
	      end
	      row = row + 1
	    end
	    row_count = 0
	    
		end

    report_content = statement_xls
    report_content.write "public/report_content.xls"
    report_name = sheet_name+"-"+start_date+"-To-"+end_date+".xls"
    send_file "public/report_content.xls", :type => "application/vnd.ms-excel", :filename => report_name, disposition: 'attachment'
	end



end
