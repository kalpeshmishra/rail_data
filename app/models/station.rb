class Station < ApplicationRecord
  belongs_to :division
  belongs_to :railway_zone
  belongs_to :state
  belongs_to :area
  has_one :load_unload
  has_many :rake_loads
  has_many :rake_unloads


  def self.set_station_upload(params)
    
    upload_file = params[:station_attachment] #params[:station][:upload_file]    
    if upload_file.present?
      today = Date.today
      random_string = SecureRandom.hex
      File.open("public/report_content_#{random_string}.xls", 'wb') { |f| f.write(upload_file.read) }
      extra_params = [upload_file.original_filename, upload_file.path]
      spreadsheet = ApplicationController.new.open_spreadsheet(extra_params[0], extra_params[1]) rescue nil
      if spreadsheet.nil? or spreadsheet.include?("Unknown file type:")
        result = {['NA', 'NA', 'NA', 'NA'] => "#{spreadsheet}"}
      else
        result = self.station_upload(spreadsheet)
        
      end

    else
    end
  end

  def self.station_upload(sheet)
    count = 0
    sheet.each_with_index do |row, index|
      next if index == 0
      sr_no = row[0] 
      station_code = row[1] 
      station_name = row[2]
      inward_outward = row[3]
      gaug = row[4]
      section = row[5]
      division = row[6]
      division_name = row[7] # not required
      zone = row[8]
      area = row[9] 
      state = row[10]
      phsg_flag = row[11]
      dpnd_flag = row[12]
      srvg_sttn = row[13]
      old_srvg_sttn = row[14]
      dfrd_flag = row[15]
      numeric_code = row[16]


      state_hash = {}
      State.all.map{|state| state_hash[state.name] = {id: state.id}}
      state_id = state_hash[state][:id] rescue nil

      zone_hash = {}
      RailwayZone.all.map{|zone| zone_hash[zone.code] = {id: zone.id}}
      zone_id = zone_hash[zone][:id] rescue nil

      division_hash = {}
      Division.all.map{|division| division_hash[division.code] = {id: division.id}}
      division_id = division_hash[division][:id] rescue nil

      area_hash = {}
      Area.all.map{|area| area_hash[area.area_code] = {id: area.id}}
      area_id = area_hash[area][:id] rescue nil

      # station_exist = Station.find_by(name: station_name) rescue nil
      # if station_exist.blank? and count < 5
      #   count += 1
      #   binding.pry
        station = Station.create(name: station_name,code: station_code,inward_outward: inward_outward, gaug: gaug,section: section,area_id: area_id,phsg_flag: phsg_flag,dpnd_flag: dpnd_flag,srvg_sttn: srvg_sttn,old_srvg_sttn: old_srvg_sttn,dfrd_flag: dfrd_flag,numeric_code: numeric_code,railway_zone_id: zone_id,division_id: division_id,state_id: state_id)
      # end
    end 
  end

end