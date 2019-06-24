class Admin::TwoRakeLoadsController < ApplicationController
layout "admin/application"

  def index
    @two_rake_loads = RakeLoad.where(rakeform_otherform: "R")
  end
  

  def show
    
  end

  def new
    data = params[:data].to_date if params[:data].present?
    data = Date.today if data.blank?
    # data = data.strftime("%Y-%m-%d")
    @two_rake_loads = RakeLoad.where(release_date: data,rakeform_otherform: "R")
    current_user_two_rake_load = []
      @two_rake_loads.each do |two_rake_load|
        rake_area =  two_rake_load.load_unload.station.area.area_code rescue nil
        current_user_area = current_user.area rescue nil
        
        if rake_area == current_user_area
          # load_unit = load_unit+two_rake_load.loaded_unit
          current_user_two_rake_load << two_rake_load
        end
      end
    @two_rake_loads = current_user_two_rake_load
    
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

  # def addcommodity
  #    respond_to do |format|
  #     format.js 
  #   end
    
  # end
  def get_data_for_form
    @from_stations = []
    LoadUnload.includes(:station).each do |load|
      @from_stations << [load.station.code, load.station.id] if load.station.present?
    end  
    @to_stations = Station.all.map{|station| [station.code,station.id]}
    @major_commodity = MajorCommodity.all.map{|major|[major.major_commodity,major.id]}
    @wagon_type = WagonType.all.map{|wagon| [wagon.stock_type_code,wagon.id]}
    @rake_commodity = {}
    MajorCommodity.includes(:rake_commodities).each do |major|
    rake_commodity_array = major.rake_commodities.map{|rake_commodity| ["#{rake_commodity.rake_commodity_code}-#{rake_commodity.rake_commodity_name}",rake_commodity.id]}
      @rake_commodity[major.id] = {data: rake_commodity_array}
    end
  end  

  def create
    RakeLoad.create_or_update_two_rake_load(params)
    data = params["date"].to_date if params["date"].present?
    data = Date.today if data.blank?
    # data = data.strftime("%Y-%m-%d")
    @two_rake_loads = RakeLoad.where(release_date: data,rakeform_otherform: "R")
    @total_rake_loads = (RakeLoad.where(release_date: data,rakeform_otherform: "R").pluck(:loaded_unit)).sum
    @total_other_loads = (RakeLoad.where(release_date: data,rakeform_otherform: "O").pluck(:loaded_unit)).sum
    get_data_for_form
    

  end

  def edit
    get_data_for_form
  end

  def update
    
  end

  def destroy
    
  end
end
