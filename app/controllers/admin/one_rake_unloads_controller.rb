class Admin::OneRakeUnloadsController < ApplicationController
  layout "admin/application"

  def index
    
  end
  

  def show
    
  end

  def new
    data = params[:data].to_date if params[:data].present?
    data = Date.today if data.blank?
    # data = data.strftime("%Y-%m-%d")
    @one_rake_unloads = RakeUnload.where(release_date: data,form_status: "RAKE")
    @total_rake_unloads = (RakeUnload.where(release_date: data,form_status: "RAKE").pluck(:loaded_unit)).sum
    @total_other_unloads = (RakeUnload.where(release_date: data,form_status: "OTHER").pluck(:loaded_unit)).sum

    get_data_for_form
  end

  # def addcommodity
  #    respond_to do |format|
  #     format.js 
  #   end
    
  # end
  def get_data_for_form
    @from_stations = []
    LoadUnload.all.each do |load|
      station = Station.find(load.station_id) rescue nil
      @from_stations << [station.code, station.id] if station.present?
    end  
    @to_stations = Station.all.map{|station| [station.code,station.id]}
    @major_commodity = MajorCommodity.all.map{|major|[major.major_commodity,major.id]}
    @wagon_type = WagonType.all.map{|wagon| [wagon.stock_type_code,wagon.id]}
    @rake_commodity = {}
    MajorCommodity.all.each do |major|
    rake_commodity_array = major.rake_commodities.map{|rake_commodity| ["#{rake_commodity.rake_commodity_code}-#{rake_commodity.rake_commodity_name}",rake_commodity.id]}
      @rake_commodity[major.id] = {data: rake_commodity_array}
    end
  end  

  def create
    RakeUnload.create_or_update_one_rake_unload(params)
    data = params["date"].to_date if params["date"].present?
    data = Date.today if data.blank?
    # data = data.strftime("%Y-%m-%d")
    @one_rake_unloads = RakeUnload.where(release_date: data,form_status: "RAKE")
    @total_rake_unloads = (RakeUnload.where(release_date: data,form_status: "RAKE").pluck(:loaded_unit)).sum
    @total_other_unloads = (RakeUnload.where(release_date: data,form_status: "OTHER").pluck(:loaded_unit)).sum
    
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
