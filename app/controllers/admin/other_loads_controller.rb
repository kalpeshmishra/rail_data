class Admin::OtherLoadsController < ApplicationController
  layout "admin/application"

  def index
  
  end
  

  def show
    
  end

  def new
    data = params[:data].to_date if params[:data].present?
    data = Date.today if data.blank?
    @other_loads = RakeLoad.where(release_date: data,rakeform_otherform: "O")

    current_user_other_load = []
      @other_loads.each do |other_load|
        rake_area =  other_load.load_unload.station.area.area_code rescue nil
        current_user_area = current_user.area rescue nil
        
        if rake_area == current_user_area
          current_user_other_load << other_load
        end
      end
    @other_loads = current_user_other_load

    @total_rake_loads = (RakeLoad.where(release_date: data,rakeform_otherform: "R"))
      load_unit = 0
      @total_rake_loads.each do |total_rake_load|
        rake_area =  total_rake_load.load_unload.station.area.area_code rescue nil
        current_user_area = current_user.area rescue nil
        
        if rake_area == current_user_area
          load_unit = load_unit+total_rake_load.loaded_unit
        end
      end
    @total_rake_loads = load_unit
    
    @total_other_loads = (RakeLoad.where(release_date: data,rakeform_otherform: "O"))
      load_unit = 0
      @total_other_loads.each do |total_other_load|
        rake_area =  total_other_load.load_unload.station.area.area_code rescue nil
        current_user_area = current_user.area rescue nil
        
        if rake_area == current_user_area
          load_unit = load_unit+total_other_load.loaded_unit
        end
      end
    @total_other_loads = load_unit

    get_data_for_form
  end

  def get_data_for_form
    @major_commodity = MajorCommodity.all.map{|major|[major.major_commodity,major.id]}
    @wagon_type = WagonType.all.map{|wagon| [wagon.wagon_type_code,wagon.id]}
    @rake_commodity = {}
    MajorCommodity.all.each do |major|
    rake_commodity_array = major.rake_commodities.map{|rake_commodity| ["#{rake_commodity.rake_commodity_code}-#{rake_commodity.rake_commodity_name}",rake_commodity.id]}
      @rake_commodity[major.id] = {data: rake_commodity_array}
    end
  end  

  
  def create
    RakeLoad.create_or_update_other_load(params)
    data = params[:data].to_date if params[:data].present?
    data = Date.today if data.blank?
    @other_loads = RakeLoad.where(release_date: data,rakeform_otherform: "O")
    current_user_other_load = []
      @other_loads.each do |other_load|
        rake_area =  other_load.load_unload.station.area.area_code rescue nil
        current_user_area = current_user.area rescue nil
        
        if rake_area == current_user_area
          current_user_other_load << other_load
        end
      end
    @other_loads = current_user_other_load

    @total_rake_loads = (RakeLoad.where(release_date: data,rakeform_otherform: "R"))
      load_unit = 0
      @total_rake_loads.each do |total_rake_load|
        rake_area =  total_rake_load.load_unload.station.area.area_code rescue nil
        current_user_area = current_user.area rescue nil
        
        if rake_area == current_user_area
          load_unit = load_unit+total_rake_load.loaded_unit
        end
      end
    @total_rake_loads = load_unit
    
    @total_other_loads = (RakeLoad.where(release_date: data,rakeform_otherform: "O"))
      load_unit = 0
      @total_other_loads.each do |total_other_load|
        rake_area =  total_other_load.load_unload.station.area.area_code rescue nil
        current_user_area = current_user.area rescue nil
        
        if rake_area == current_user_area
          load_unit = load_unit+total_other_load.loaded_unit
        end
      end
    @total_other_loads = load_unit
    get_data_for_form

  end

  def find_to_station_other_loads # finds to station
    
    station_code = params[:station_code]
    @to_station = params[:to_station_id]
    @stn = Station.find_by(code: station_code)? true : false
        
      respond_to do |format|
        format.js
      end
    
  end

  def find_from_station_other_loads
    
    get_user_area

    from_station_code = params[:from_station_code]
    @from_station = params[:from_station_id]
    from_station_code_id = Station.where(code: from_station_code).pluck(:id)
    @stn = LoadUnload.find_by(station_id: from_station_code_id, area_id: @user_area_id)? true : false
    
      respond_to do |format|
        format.js
      end
    
  end

  def get_user_area
    user_area = current_user.area
    if user_area.present? 
      @user_area_id = Area.where(area_code: user_area).pluck(:id)
    end 
    
  end

  def delete_other_load
    delete_other_load_id = params[:delete_other_load_id]
    id = delete_other_load_id.to_i
    RakeLoad.destroy(id)
   
      respond_to do |format|
        format.js
      end
  end

  def edit
    get_data_for_form
  end

  def update
    
  end

  def destroy
    
  end
end
