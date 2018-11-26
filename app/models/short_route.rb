class ShortRoute < ApplicationRecord

  def self.set_short_route_upload(params)
    
    upload_file = params[:short_route_attachment] 
    if upload_file.present?
      today = Date.today
      random_string = SecureRandom.hex
      File.open("public/report_content_#{random_string}.xls", 'wb') { |f| f.write(upload_file.read) }
      extra_params = [upload_file.original_filename, upload_file.path]
      spreadsheet = ApplicationController.new.open_spreadsheet(extra_params[0], extra_params[1]) rescue nil
      if spreadsheet.nil? or spreadsheet.include?("Unknown file type:")
        result = {['NA', 'NA', 'NA', 'NA'] => "#{spreadsheet}"}
      else
        result = self.short_route_upload(spreadsheet)
        
      end

    else
    end
  end

  def self.short_route_upload(sheet)
    
    sheet.each_with_index do |row, index|
      next if index == 0
      from_station = row[0] 
      to_station = row[1] 
      distance = row[2]
      interchange_point = row[3]
      description = row[4]
      
      ShortRoute.create(from_station: from_station,to_station: to_station,distance: distance, interchange_point: interchange_point, description: description)
    end 
  end
end
