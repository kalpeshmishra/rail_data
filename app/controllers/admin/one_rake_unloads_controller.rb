class Admin::OneRakeUnloadsController < ApplicationController
  layout "admin/application"

  def index
    
  end
  

  def show
    
  end

  def new
    data = params[:data].to_date if params[:data].present?
    data = Date.today if data.blank?
    
    @one_rake_unloads = RakeUnload.where(release_date: data,form_status: "RAKE")
    get_user_area_wise_data(data)
    get_data_for_form
  end
  
  def create
    if params[:is_rake_commodity].present? and params[:is_rake_commodity] == "true"
      RakeUnloadsRakeCommodity.create_rake_unloads_rake_commodity(params)
    else
      RakeUnload.create_or_update_one_rake_unload(params)
      data = params["date"].to_date if params["date"].present?
      data = Date.today if data.blank?
      @one_rake_unloads = RakeUnload.where(release_date: data,form_status: "RAKE")
      get_user_area_wise_data(data)
      get_data_for_form
    end
  end

  def get_user_area_wise_data(data)
    current_user_rake_unload = []
      @one_rake_unloads.each do |rake_unload|
        rake_area =  rake_unload.load_unload.station.area.area_code rescue nil
        current_user_area = current_user.area rescue nil
        
        if rake_area == current_user_area
          current_user_rake_unload << rake_unload
        end
      end
    @one_rake_unloads = current_user_rake_unload
    @total_rake_unloads = (RakeUnload.where(release_date: data,form_status: "RAKE"))
      load_unit = 0
      @total_rake_unloads.each do |total_rake_unload|
        rake_area =  total_rake_unload.load_unload.station.area.area_code rescue nil
        current_user_area = current_user.area rescue nil
        
        if rake_area == current_user_area
          load_unit = load_unit + total_rake_unload.loaded_unit
        end
      end
    @total_rake_unloads = load_unit  

    @total_other_unloads = (RakeUnload.where(release_date: data,form_status: "OTHER"))
      load_unit = 0
      @total_other_unloads.each do |total_other_unload|
        rake_area =  total_other_unload.load_unload.station.area.area_code rescue nil
        current_user_area = current_user.area rescue nil
        
        if rake_area == current_user_area
          load_unit = load_unit+total_other_unload.loaded_unit
        end
      end
    @total_other_unloads = load_unit
    
  end

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

  def edit
    get_data_for_form
  end

  def unload_commodity_breakup
    
    @rake_unload_id = params[:rake_unload_id]
    @rake_unload = RakeUnload.find(@rake_unload_id)
    @major_commodity_id = @rake_unload.major_commodity_id
    @unload_commodity_breakup_values =  RakeUnloadsRakeCommodity.where(rake_unload_id: @rake_unload_id)
    @rake_unloads_rake_commodity_ids  = @unload_commodity_breakup_values.pluck(:rake_commodity_id)
    get_data_for_form
    respond_to do |format|
      format.js
    end
  end

  def delete_unload_rake_commodity_breakup
    delete_unload_rake_commodity_breakup_id = params[:delete_unload_rake_commodity_breakup_id]
    id = delete_unload_rake_commodity_breakup_id.to_i
    
    RakeUnloadsRakeCommodity.destroy(id)
   
    respond_to do |format|
      format.js
    end
  end

  def update
    
  end

  def destroy
    
  end

end
