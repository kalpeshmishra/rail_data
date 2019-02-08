class MonthRakeLoad < ApplicationRecord
belongs_to :station
belongs_to :major_commodity
belongs_to :wagon_type

	def self.set_month_rake_load_upload(params)
		# binding.pry
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

	def self.month_rake_load_upload(sheet)
    sheet.each_with_index do |row, index|
      next if index == 0
      month = row[0] 
      from_station = row[1] 
      to_station = row[2]
      rake_count = row[3]
      loaded_unit = row[4]
      total_unit = row[5]
      major_commodity = [6]
      wagon_type = row[7]
      double_stack = row[8]
      tues_first = row[9]
      tues_second = row[10]
    # binding.pry
      
    end 
  end
end
