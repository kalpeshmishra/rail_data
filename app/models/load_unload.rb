class LoadUnload < ApplicationRecord
  
  belongs_to :division
  belongs_to :area
  belongs_to :station
  has_many :rake_loads
  has_many :rake_unloads

  def self.set_load_unload_upload(params)
    
    upload_file = params[:load_unload_attachment] 
    if upload_file.present?
      today = Date.today
      random_string = SecureRandom.hex
      File.open("public/report_content_#{random_string}.xls", 'wb') { |f| f.write(upload_file.read) }
      extra_params = [upload_file.original_filename, upload_file.path]
      spreadsheet = ApplicationController.new.open_spreadsheet(extra_params[0], extra_params[1]) rescue nil
      if spreadsheet.nil? or spreadsheet.include?("Unknown file type:")
        result = {['NA', 'NA', 'NA', 'NA'] => "#{spreadsheet}"}
      else
        result = self.load_unload_upload(spreadsheet)
        
      end

    else
    end
  end

  def self.load_unload_upload(sheet)
    
    sheet.each_with_index do |row, index|
      next if index == 0
      sr_no = row[0] 
      serving_station = row[1] 
      station = row[2]
      area = row[3]
      division = row[4]
      status = row[5]
      desc = row[6]

      station_hash = {}
      Station.all.map{|station| station_hash[station.code] = {id: station.id}}
      station_id = station_hash[station][:id] rescue nil

      area_hash = {}
      Area.all.map{|area| area_hash[area.area_code] = {id: area.id}}
      area_id = area_hash[area][:id] rescue nil

      division_hash = {}
      Division.all.map{|division| division_hash[division.code] = {id: division.id}}
      division_id = division_hash[division][:id] rescue nil

            
      LoadUnload.create(serving_station: serving_station,station_id: station_id,area_id: area_id,division_id: division_id ,status: status, desc: desc)
    end 
  end
  
end