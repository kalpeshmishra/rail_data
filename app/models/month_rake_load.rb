class MonthRakeLoad < ApplicationRecord
belongs_to :station
belongs_to :major_commodity
belongs_to :wagon_type

	def self.set_month_rake_load_upload(params)
		if params[:month_rake_load].present?
			upload_file = params[:month_rake_load]    
		    if upload_file.present?
		      today = Date.today
		      random_string = SecureRandom.hex
		      File.open("public/report_content_#{random_string}.xls", 'wb') { |f| f.write(upload_file.read) }
		      extra_params = [upload_file.original_filename, upload_file.path]
		      spreadsheet = ApplicationController.new.open_spreadsheet(extra_params[0], extra_params[1]) rescue nil
		      if spreadsheet.nil? or spreadsheet.include?("Unknown file type:")
		        result = {['NA', 'NA', 'NA', 'NA'] => "#{spreadsheet}"}
		      else
		        result = self.month_rake_load_upload(spreadsheet)
		      end
		    end
	  end
	  if params[:month_phasewise_rake_load].present?
			upload_file = params[:month_phasewise_rake_load]    
		    if upload_file.present?
		      today = Date.today
		      random_string = SecureRandom.hex
		      File.open("public/report_content_#{random_string}.xls", 'wb') { |f| f.write(upload_file.read) }
		      extra_params = [upload_file.original_filename, upload_file.path]
		      spreadsheet = ApplicationController.new.open_spreadsheet(extra_params[0], extra_params[1]) rescue nil
		      if spreadsheet.nil? or spreadsheet.include?("Unknown file type:")
		        result = {['NA', 'NA', 'NA', 'NA'] => "#{spreadsheet}"}
		      else
		        result = self.month_phasewise_rake_load_upload(spreadsheet)
		      end
		    end
	  end

	end

	def self.month_rake_load_upload(sheet)
    major_commodity_hash = {}
    MajorCommodity.all.map{|major_commodity| major_commodity_hash[major_commodity.major_commodity] = {id: major_commodity.id}}
    wagon_type_hash = {}
    WagonType.all.map{|wagon_type| wagon_type_hash[wagon_type.wagon_type_code] = {id: wagon_type.id}}
        
    sheet.each_with_index do |row, index|
      next if index == 0
      load_month = row[0] 
      from_station_id = Station.where(code: row[1]).pluck(:id)[0]
      load_unload_id = LoadUnload.where(station_id: from_station_id).pluck(:id)[0]
      station_id = Station.where(code: row[2]).pluck(:id)[0] # To station ID
      rake_count = row[3]
      loaded_unit = row[4]
      total_unit = row[5]
      major_commodity = row[6]
      wagon_type = row[7]
      double_stack = row[8]
      tue_first_row = row[9]
      tue_second_row = row[10]

    	major_commodity_id = major_commodity_hash[major_commodity][:id] rescue nil
      wagon_type_id = wagon_type_hash[wagon_type][:id] rescue nil
    
    	MonthRakeLoad.create(load_month: load_month,load_unload_id: load_unload_id,station_id: station_id,loaded_unit: loaded_unit, total_unit: total_unit, wagon_type_id: wagon_type_id, major_commodity_id: major_commodity_id, double_stack: double_stack,tue_first_row: tue_first_row, tue_second_row: tue_second_row)
    end 
  end

  def self.month_phasewise_rake_load_upload(sheet)
    sheet.each_with_index do |row, index|
  		next if index == 0
      load_month = row[0].strftime("%b-%Y")
      load_unload_id = Station.where(code: row[1]).pluck(:id)[0]
      commodity_type = row[2]
      rake_count = row[3]
      loaded_unit = row[4]
      base_date = DateTime.parse("1900-01-01 00:00")
      if row[5].class != Integer #row[5] > 86340
      	detn_arr_pla = (DateTime.parse(row[5].to_s)+2).to_i - base_date.to_i
      	detention_arrival_placement = self.get_hours(detn_arr_pla)
      else
      	detention_arrival_placement = self.get_hours(row[5])	
      end
      if row[6].class != Integer #row[6] > 86340
      	detn_pla_rel = (DateTime.parse(row[6].to_s)+2).to_i - base_date.to_i
      	detention_placement_release = self.get_hours(detn_pla_rel)
      else
      	detention_placement_release = self.get_hours(row[6])	
      end
      if row[7].class != Integer #row[7] > 86340
      	detn_rel_dep = (DateTime.parse(row[7].to_s)+2).to_i - base_date.to_i
      	detention_release_departure = self.get_hours(detn_rel_dep)
      else
      	detention_release_departure = self.get_hours(row[7])	
      end
      
      MonthPhasewiseRakeLoad.create(load_month: load_month, load_unload_id: load_unload_id, commodity_type: commodity_type, rake_count: rake_count, loaded_unit: loaded_unit,detention_arrival_placement: detention_arrival_placement,detention_placement_release: detention_placement_release, detention_release_departure: detention_release_departure)
  	end
  end

  def self.get_hours(total_hours)
  	seconds = total_hours % 60
    if seconds > 56
    	total_hours = total_hours + 1
      seconds = 0
    end
		
		minutes = (total_hours / 60) % 60
    hours = total_hours / (60 * 60)
		format("%02d:%02d:%02d", hours, minutes, seconds)
  end 

end
