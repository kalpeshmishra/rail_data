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
		elsif params[:report_type] == "UnloadingData"
			sheet_name = "UnloadingData"
		elsif params[:report_type] == "GG-LoadingData"
			sheet_name = "GG-LoadingData"
		elsif params[:report_type] == "GETS-Data"
			sheet_name = "GETS-Data"		
		end

		statement_xls = Spreadsheet::Workbook.new
    sheet = statement_xls.create_worksheet :name => sheet_name
    
    header = [["Loading Data From:"+start_date+"-To:"+end_date],["SrNo.","Month","Area","From ", "To   ", "ForecastDate", "RakeReceived", "LoadedUnit", "TotalUnit","Stock","Arrival Time/Date", "Placement Time/Date", "Release Time/Date", "Power-Arr Time/Date", "Removal Time/Date", "Departure Time/Date", "Power", "BpcType", "BpcStn", "BpcDate", "Tues 1St", "Tues 2nd", "CommodityType", "ODR-Type", "ODR-Date", "Consignor", "Consignee","Short I/C Point","Short KM" , "Actual I/C Point", "I/C Time/Date", "Detn(AR-PM)", "Detn(PM-RL)", "Detn(RL-PA)", "Detn(PA-DEP)", "Detn(RL-DEP)" ]]
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
      
      rake_load_row_values = [index,load_data.release_date.strftime('%b-%y'),load_data.load_unload.area.area_code,load_data.load_unload.station.code, load_data.station.code, load_data.wagon_type.wagon_type_code, load_data.rake_count, load_data.loaded_unit, load_data.major_commodity.major_commodity,(load_data.arrival_time+" " + load_data.arrival_date.strftime('%d-%m-%y')).to_time.strftime("%H:%M %d-%m-%y"), load_data.stack]
      rake_load_row_values.each_with_index do |content, index|
        sheet[row_count, index] = content
      end
    end
    report_content = statement_xls
    report_content.write "public/report_content.xls"
    report_name = sheet_name+"-"+start_date+"-To-"+end_date+".xls"
    send_file "public/report_content.xls", :type => "application/vnd.ms-excel", :filename => report_name, disposition: 'attachment'
	end
end
