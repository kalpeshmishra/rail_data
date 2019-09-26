class Station < ApplicationRecord
  belongs_to :division
  belongs_to :railway_zone
  belongs_to :state
  belongs_to :area
  has_one :load_unload
  has_many :rake_loads
  has_many :month_rake_loads
  has_many :rake_unloads
  has_many :station_under_ti_users


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

   # rakeload =[]
   
  # def self.kal(rakeload)
    
  #   error_rakeload = []
  #   rakeload.each do |rakeload|      
  #     load_unload_id = LoadUnload.find_by(station_id: Station.find_by(code: rakeload[0]).id).id rescue nil
  #     station_id = Station.find_by(code: rakeload[1]).id rescue nil
  #     wagon_type_id = WagonType.find_by(wagon_type_code: rakeload[6]).id rescue nil
  #     major_commodity_id = MajorCommodity.find_by(major_commodity: rakeload[8]).id rescue nil
     
  #     # r = RakeLoad.create(load_unload_id: load_unload_id,station_id: station_id, forecast_date: rakeload[2].to_date,rake_received: rakeload[3],loaded_unit: rakeload[4],total_unit: rakeload[5],wagon_type_id: wagon_type_id,rake_count: rakeload[7],major_commodity_id: major_commodity_id,odr_type: rakeload[9],arrival_time: rakeload[10],arrival_date: rakeload[11].to_date,placement_time: rakeload[12],placement_date: rakeload[13].to_date,release_time: rakeload[14],release_date: rakeload[15].to_date,powerarrival_time: rakeload[16],powerarrival_date: rakeload[17].to_date,departure_time: rakeload[18],departure_date: rakeload[19].to_date,power_no: rakeload[20],rakeform_otherform: "R",detention_arrival_placement: rakeload[21],detention_placement_release: rakeload[22],detention_removal_departure: rakeload[23],detention_release_powerarrival: rakeload[24],detention_powerarrival_departure: rakeload[25])

  #     r = RakeLoad.create(load_unload_id: load_unload_id,station_id: station_id, forecast_date: rakeload[2].to_date,rake_received: rakeload[3],loaded_unit: rakeload[4],total_unit: rakeload[5],wagon_type_id: wagon_type_id,rake_count: rakeload[7],major_commodity_id: major_commodity_id,odr_type: rakeload[9],arrival_time: rakeload[10],arrival_date: rakeload[11].to_date,placement_time: rakeload[12],placement_date: rakeload[13].to_date,release_time: rakeload[14],release_date: rakeload[15].to_date,rakeform_otherform: "R",detention_arrival_placement: rakeload[16],detention_placement_release: rakeload[17],net_tons: rakeload[18],stack: rakeload[19],short_km:rakeload[20], short_interchange:rakeload[21])

  #     if r.save
  #     else
  #       error_rakeload << rakeload
  #       # binding.pry
  #     end
      
  #   end
  # end

  # rakeunload = []
  # def self.kal(rakeunload)
    
  #   error_rakeunload = []
  #   rakeunload.each do |rakeunload|      
  #     station_id = Station.find_by(code: rakeunload[0]).id rescue nil
  #     load_unload_id = LoadUnload.find_by(station_id: Station.find_by(code: rakeunload[1]).id).id rescue nil
  #     wagon_type_id = WagonType.find_by(wagon_type_code: rakeunload[4]).id rescue nil
  #     major_commodity_id = MajorCommodity.find_by(major_commodity: rakeunload[7]).id rescue nil
     
  #     r = RakeUnload.create(station_id: station_id, load_unload_id: load_unload_id, loaded_unit: rakeunload[2],total_unit: rakeunload[3],wagon_type_id: wagon_type_id,stock_description: rakeunload[5],rake_count: rakeunload[6],major_commodity_id: major_commodity_id,arrival_time: rakeunload[8],arrival_date: rakeunload[9].to_date,placement_time: rakeunload[10],placement_date: rakeunload[11].to_date,release_time: rakeunload[12],release_date: rakeunload[13].to_date,removal_time:rakeunload[14],removal_date:rakeunload[15],remarks:rakeunload[16],form_status: "RAKE",detention_arrival_placement: rakeunload[17],detention_placement_release: rakeunload[18],detention_release_removal: rakeunload[19])

  #     if r.save
  #     else
  #       error_rakeunload << rakeunload
  #       binding.pry
  #     end
      
  #   end
  # end

  rakeunload = []
  def self.kal(rakeunload)
    
    error_rakeunload = []
    rakeunload.each do |rakeunload|      
      station_id = Station.find_by(code: rakeunload[0]).id rescue nil
      load_unload_id = LoadUnload.find_by(station_id: Station.find_by(code: rakeunload[1]).id).id rescue nil
      wagon_type_id = WagonType.find_by(wagon_type_code: rakeunload[8]).id rescue nil
      major_commodity_id = MajorCommodity.find_by(major_commodity: rakeunload[11]).id rescue nil
     
      r = RakeUnload.create(station_id: station_id, load_unload_id: load_unload_id, takenover_point:rakeunload[2],collary: rakeunload[3],takenover_time: rakeunload[4],takenover_date: rakeunload[5].to_date,loaded_unit: rakeunload[6],total_unit: rakeunload[7],wagon_type_id: wagon_type_id,rake_count: rakeunload[9],stock_description: rakeunload[10],major_commodity_id: major_commodity_id,commodity_type:rakeunload[12],bpc_type:rakeunload[13],arrival_time: rakeunload[14],arrival_date: rakeunload[15].to_date,placement_time: rakeunload[16],placement_date: rakeunload[17].to_date,release_time: rakeunload[18],release_date: rakeunload[19].to_date,powerarrival_time: rakeunload[20],powerarrival_date: rakeunload[21].to_date,removal_time:rakeunload[22],removal_date:rakeunload[23].to_date,departure_time:rakeunload[22],departure_date:rakeunload[23].to_date,handedover_point:rakeunload[24],empty_destination:rakeunload[25],form_status: "GETS",detention_arrival_placement: rakeunload[26],detention_placement_release: rakeunload[27],detention_release_removal: rakeunload[28])

      if r.save
      else
        error_rakeunload << rakeunload
        # binding.pry
      end
      
    end
  end




end