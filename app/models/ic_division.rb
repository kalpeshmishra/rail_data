class IcDivision < ApplicationRecord
  belongs_to :railway_zone
  belongs_to :division

  def self.set_ic_division_upload(params)
    
    upload_file = params[:ic_division_attachment] #params[:ic_division][:upload_file]    
    if upload_file.present?
      today = Date.today
      random_string = SecureRandom.hex
      File.open("public/report_content_#{random_string}.xls", 'wb') { |f| f.write(upload_file.read) }
      extra_params = [upload_file.original_filename, upload_file.path]
      spreadsheet = ApplicationController.new.open_spreadsheet(extra_params[0], extra_params[1]) rescue nil
      if spreadsheet.nil? or spreadsheet.include?("Unknown file type:")
        result = {['NA', 'NA', 'NA', 'NA'] => "#{spreadsheet}"}
      else
        result = self.ic_division_upload(spreadsheet)
        
      end

    else
    end
  end

  def self.ic_division_upload(sheet)
    
    sheet.each_with_index do |row, index|
      next if index == 0
      sr_no = row[0] 
      zone = row[1]   
      division = row[2]
      from_section = row[3]
      ic_code = row[4]
      ic_name = row[5]
      to_section = row[6]
      to_division = row[7]
      to_zone = row[8]
      ic_by = row[9]
      interchange_type = row[10]
      
      zone_hash = {}
      RailwayZone.all.map{|zone| zone_hash[zone.code] = {id: zone.id}}
      zone_id = zone_hash[zone][:id] rescue nil

      division_hash = {}
      Division.all.map{|division| division_hash[division.code] = {id: division.id}}
      division_id = division_hash[division][:id] rescue nil

      IcDivision.create(railway_zone_id: zone_id,division_id: division_id,from_section: from_section,ic_code: ic_code, ic_name: ic_name, to_section: to_section, to_division: to_division, to_zone: to_zone, ic_by: ic_by, interchange_type: interchange_type)
    end 
  end
end
