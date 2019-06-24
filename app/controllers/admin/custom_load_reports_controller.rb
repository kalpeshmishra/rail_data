class Admin::CustomLoadReportsController < ApplicationController
	layout "admin/application"

	def index
		get_report_data(params)
	end

	def get_report_data(params)
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
		@custom_date_station_list = station_list.compact.uniq 
		@custom_date_commodity_list = commodity_list.compact.uniq.sort
		
		if params[:is_date_station_filter].present? and params[:selected_stations].present?
     	load_and_unload_ids = params[:selected_stations].split(',').map{|x|x.to_i}.delete_if {|x| x ==0}
     	@custom_date_station_commodity_list = load_and_unload_ids.uniq.map{|load_unload_id| MajorCommodity.find(rake_load_data.where(load_unload_id: load_unload_id).map{|maj_comm|maj_comm.major_commodity_id}) rescue nil}.flatten
      @custom_date_station_commodity_list = @custom_date_station_commodity_list.map{|x| [x.major_commodity,x.id]}.uniq
		end

		if params[:is_date_data_filter].present? 
			load_unload_ids = params[:selected_stations].split(',').map{|x|x.to_i}.delete_if {|x| x ==0}
			major_commodity_ids = params[:selected_commodity].split(',').map{|x|x.to_i}.delete_if {|x| x ==0}
			@custom_date_report_data = rake_load_data.where(load_unload_id: load_unload_ids,major_commodity_id: major_commodity_ids)
			@custom_date_report_data = @custom_date_report_data.order(:release_date)
			@custom_date_total_rake = @custom_date_report_data.map{|x| [x.rake_count]}.flatten.sum
			@custom_date_total_unit = @custom_date_report_data.map{|x| [x.loaded_unit]}.flatten.sum
			@custom_date_total_double_stack = @custom_date_report_data.map{|x| x.stack}.reject(&:blank?).count("DOUBLE")
		end

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
			 		load_unload_code = value.load_unload.station.code
			 		station_list << [load_unload_code,value.load_unload_id ]
			 	end
		 	end	
			@custom_load_report_station = station_list.compact.uniq

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
			 		commodity_code = value.major_commodity.major_commodity
			 		commodity_list << [commodity_code,value.major_commodity.id ]
			 	end
		 	end	
			@custom_month_station_commodity = commodity_list.compact.uniq
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
			@custom_month_report_header = months
			@custom_month_report_data = data_hash
			
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
			@custom_load_report_year_station = station_list.compact.uniq
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
			@custom_year_station_commodity = commodity_list.compact.uniq
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
			@custom_year_report_header = year
			@custom_year_report_data = data_hash
		end
	end

	def custom_load_report_excel_download #For DateWise Excel
		require 'roo'
		start_date = params[:from_date]if params[:from_date].present?
		end_date = params[:to_date] if params[:to_date].present?
		
		get_report_data(params)

		statement_xls = Spreadsheet::Workbook.new
    sheet = statement_xls.create_worksheet :name => "CustomLoadingReport"
    
    header = [["Loading Report DateWise From:"+start_date+"-To:"+end_date],["SrNo.","Release Date", "From ", "To   ", "Stock", "Rake", "Unit", "Commodity","Stack   "]]
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
    
    @custom_date_report_data.each.with_index(1) do |load_data, index|
      row_count = index + 1
      rake_load_row_values = [index,load_data.release_date.strftime('%d-%m-%y'),load_data.load_unload.station.code, load_data.station.code, load_data.wagon_type.wagon_type_code, load_data.rake_count, load_data.loaded_unit, load_data.major_commodity.major_commodity, load_data.stack]
      rake_load_row_values.each_with_index do |content, index|
        sheet[row_count, index] = content
      end
    end
    report_content = statement_xls
    report_content.write "public/report_content.xls"
    report_name = "Custom-DateWise-LoadingReport-From-"+start_date+"-To-"+end_date+".xls"
    send_file "public/report_content.xls", :type => "application/vnd.ms-excel", :filename => report_name, disposition: 'attachment'
	end

	def month_custom_load_report_excel_download #For DateWise Excel
		require 'roo'
		get_report_data(params)
		# Excel download pending 
		statement_xls = Spreadsheet::Workbook.new
			header_bold_cells = Spreadsheet::Format.new(:weight => :bold, :align => :center)
      body_align_cells = Spreadsheet::Format.new(:align => :center)
      bold_cell = Spreadsheet::Format.new(:weight => :bold)
      # Start Header
			sheet = statement_xls.create_worksheet :name => "Form A"
			sheet[0, 0] = "SCHEDULE"
      sheet.merge_cells(0, 0, 1, 2)
      sheet.row(0).default_format = header_bold_cells
   #    sheet[1, 0] = "[See rule 2(1)]"
   #    sheet.merge_cells(1, 0,1, 25)
   #    sheet.row(1).default_format = header_bold_cells
      sheet[2, 0] = "Form A"
      sheet.merge_cells(2, 0, 2, 4)
      sheet.row(2).default_format = header_bold_cells
			# sheet[3, 0] = "FORMAT OF EMPLOYEE REGISTER"
   #    sheet.merge_cells(3, 0, 3, 25)
   #    sheet.row(3).default_format = header_bold_cells
   #    sheet[4, 0] = "Name of the Establishment"
   #    sheet.merge_cells(4, 0, 4, 2)

    header = ["Sl. No.","Employee Code","Name","Surname","Gender","Father’s/Spouse Name","Date of Birth","Nationality","Education Level","Date of Joining","Designation","Category Address","Type of Employment","Mobile","UAN","PAN","ESIC IP","LWF","AADHAAR","Bank A/c Number",	"Bank","Branch (IFSC)","Present Address","Permanent Address","Servie Book No.","Date of Exit","Reason for Exit","Mark of Identification","Photo","Specimen Signature/Thumb Impression","Remarks"]
	    
      header.each_with_index do |h,i|
	     	sheet[8, i] = h
	     	sheet[9, i] = i + 1
	    end
	  report_content = statement_xls
    report_content.write "public/report_content.xls"
    send_file "public/report_content.xls", :type => "application/vnd.ms-excel", :filename => "report_name.xls", disposition: 'attachment'
	end
	def show
	end
	
end
