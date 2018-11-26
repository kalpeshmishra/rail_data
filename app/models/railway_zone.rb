class RailwayZone < ApplicationRecord
  has_many :divisions
  has_many :stations
  has_many :areas
  has_many :ic_divisions

  def self.set_railway_zone_upload(params)
    
    upload_file = params[:railway_zone_attachment] 
    if upload_file.present?
      today = Date.today
      random_string = SecureRandom.hex
      File.open("public/report_content_#{random_string}.xls", 'wb') { |f| f.write(upload_file.read) }
      extra_params = [upload_file.original_filename, upload_file.path]
      spreadsheet = ApplicationController.new.open_spreadsheet(extra_params[0], extra_params[1]) rescue nil
      if spreadsheet.nil? or spreadsheet.include?("Unknown file type:")
        result = {['NA', 'NA', 'NA', 'NA'] => "#{spreadsheet}"}
      else
        result = self.railway_zone_upload(spreadsheet)
        
      end

    else
    end
  end

  def self.railway_zone_upload(sheet)
    
    sheet.each_with_index do |row, index|
      next if index == 0
      sr_no = row[0] 
      code = row[1] 
      name= row[2]
      zone_headquarter = row[3]
      RailwayZone.create(code: code,name: name,zone_headquarter: zone_headquarter)
    end 
  end
end
