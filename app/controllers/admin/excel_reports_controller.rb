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
			gg_loading_data = RakeLoad.where(release_date: start_date..end_date)
			statement_xls = Spreadsheet::Workbook.new
	    sheet = statement_xls.create_worksheet :name => sheet_name
	    gg_commodity = ["COTN","SALT"]
	    fixed_header = ["SrNo", "Month", "From", "To", "Release Time/Date", "Loaded Unit"]
	    temp_array = fixed_header + gg_commodity 
	    
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
	    gg_loading_data.each.with_index(1) do |gg_data, index|
	      row_count = index + 1

	      if gg_data.release_time == ""
	      	gg_data.release_time = nil
	      end	
	      if gg_data.release_date == ""
	      	gg_data.release_date = nil
	      end	
	      
	      
	      # gg_load_row_values = [index,gg_data.release_date&.strftime('%b-%y'),gg_data.load_unload.area.area_code,gg_data.load_unload.station.code, gg_data.station.code, gg_data.forecast_date&.strftime('%d-%m-%y'), gg_data.rake_received, gg_data.rake_count, gg_data.loaded_unit, gg_data.total_unit, gg_data.wagon_type.wagon_type_code, gg_data.major_commodity.major_commodity, gg_data.stack, (gg_data.arrival_time&.first(5)&.concat(" ")&.concat(gg_data.arrival_date&.strftime('%d-%m-%y'))),(gg_data.placement_time&.first(5)&.concat(" ")&.concat(gg_data.placement_date&.strftime('%d-%m-%y'))),(gg_data.release_time&.first(5)&.concat(" ")&.concat(gg_data.release_date&.strftime('%d-%m-%y'))),(gg_data.powerarrival_time&.first(5)&.concat(" ")&.concat(gg_data.powerarrival_date&.strftime('%d-%m-%y'))),(gg_data.removal_time&.first(5)&.concat(" ")&.concat(gg_data.removal_date&.strftime('%d-%m-%y'))),(gg_data.departure_time&.first(5)&.concat(" ")&.concat(gg_data.departure_date&.strftime('%d-%m-%y'))),gg_data.power_no, gg_data.bpc_type, gg_data.bpc_station, gg_data.bpc_date, gg_data.tue_first_row, gg_data.tue_second_row, gg_data.commodity_type, gg_data.odr_type, gg_data.odr_date, gg_data.consignor, gg_data.consignee, gg_data.short_interchange, gg_data.short_km, gg_data.actual_interchange,(gg_data.ic_time&.first(5)&.concat(" ")&.concat(gg_data.ic_date&.strftime('%d-%m-%y'))), gg_data.detention_arrival_placement, gg_data.detention_placement_release, gg_data.detention_release_powerarrival, gg_data.detention_powerarrival_departure, gg_data.detention_removal_departure, gg_data.remark]
	      # gg_load_row_values.each_with_index do |content, index|
	      #   sheet[row_count, index] = content
	      # end
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
		end


    report_content = statement_xls
    report_content.write "public/report_content.xls"
    report_name = sheet_name+"-"+start_date+"-To-"+end_date+".xls"
    send_file "public/report_content.xls", :type => "application/vnd.ms-excel", :filename => report_name, disposition: 'attachment'
	end



end
