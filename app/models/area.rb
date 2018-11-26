class Area < ApplicationRecord
  belongs_to :railway_zone
  belongs_to :division
  has_many :load_unloads
  has_many :stations
  has_many :users

   def self.set_area_upload(params)
    
    upload_file = params[:area_attachment] #params[:area][:upload_file]    
    if upload_file.present?
      today = Date.today
      random_string = SecureRandom.hex
      File.open("public/report_content_#{random_string}.xls", 'wb') { |f| f.write(upload_file.read) }
      extra_params = [upload_file.original_filename, upload_file.path]
      spreadsheet = ApplicationController.new.open_spreadsheet(extra_params[0], extra_params[1]) rescue nil
      if spreadsheet.nil? or spreadsheet.include?("Unknown file type:")
        result = {['NA', 'NA', 'NA', 'NA'] => "#{spreadsheet}"}
      else
        result = self.area_upload(spreadsheet)
        
      end

    else
    end
  end

  def self.area_upload(sheet)
    
    sheet.each_with_index do |row, index|
      next if index == 0
      sr_no = row[0] 
      zone = row[1] 
      division = row[2]
      area_code = row[3]
      area_name = row[4]
      
      zone_hash = {}
      RailwayZone.all.map{|zone| zone_hash[zone.code] = {id: zone.id}}
      zone_id = zone_hash[zone][:id] rescue nil

      division_hash = {}
      Division.all.map{|division| division_hash[division.code] = {id: division.id}}
      division_id = division_hash[division][:id] rescue nil

      Area.create(railway_zone_id: zone_id,division_id: division_id,area_code: area_code,area_name: area_name)
    end 
  end
end
