class Division < ApplicationRecord
  belongs_to :railway_zone
  has_many :stations
  has_many :areas
  has_many :ic_divisions
  has_many :load_unloads

  # has_many :users

  def self.set_division_upload(params)
    
    upload_file = params[:division_attachment] #params[:division][:upload_file]    
    if upload_file.present?
      today = Date.today
      random_string = SecureRandom.hex
      File.open("public/report_content_#{random_string}.xls", 'wb') { |f| f.write(upload_file.read) }
      extra_params = [upload_file.original_filename, upload_file.path]
      spreadsheet = ApplicationController.new.open_spreadsheet(extra_params[0], extra_params[1]) rescue nil
      if spreadsheet.nil? or spreadsheet.include?("Unknown file type:")
        result = {['NA', 'NA', 'NA', 'NA'] => "#{spreadsheet}"}
      else
        result = self.division_upload(spreadsheet)
        
      end

    else
    end
  end

  def self.division_upload(sheet)
    
    sheet.each_with_index do |row, index|
      next if index == 0
      sr_no = row[0] 
      zone = row[1] 
      code = row[2]
      name = row[3]
      
      zone_hash = {}
      RailwayZone.all.map{|zone| zone_hash[zone.code] = {id: zone.id}}
      zone_id = zone_hash[zone][:id] rescue nil

      Division.create(railway_zone_id: zone_id,name: name,code: code)
  end 
  end
end 








