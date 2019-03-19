class Admin::OtherUnloadsController < ApplicationController
  layout "admin/application"

  def index
    
  end
  

  def show
    
  end

  def new
    data = params[:data].to_date if params[:data].present?
    data = Date.today if data.blank?
    # data = data.strftime("%Y-%m-%d")
    @other_unloads = RakeUnload.where(release_date: data,form_status: "OTHER")
    @other_unloads += RakeUnload.where(release_date: nil,form_status: "OTHER")
    @other_unloads += RakeUnload.where(release_date: "",form_status: "OTHER")
    @total_rake_unloads = (RakeUnload.where(release_date: data,form_status: "RAKE").pluck(:loaded_unit)).sum
    @total_other_unloads = (RakeUnload.where(release_date: data,form_status: "OTHER").pluck(:loaded_unit)).sum
   

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
    RakeUnload.create_or_update_other_unload(params)
    data = params[:date].to_date if params[:date].present?
    data = Date.today if data.blank?
    # data = data.strftime("%Y-%m-%d")
    @other_unloads = RakeUnload.where(release_date: data,form_status: "OTHER")
    @other_unloads += RakeUnload.where(release_date: nil,form_status: "OTHER")
    @other_unloads += RakeUnload.where(release_date: "",form_status: "OTHER")
    @total_rake_unloads = (RakeUnload.where(release_date: data,form_status: "RAKE").pluck(:loaded_unit)).sum
    @total_other_unloads = (RakeUnload.where(release_date: data,form_status: "OTHER").pluck(:loaded_unit)).sum
    
    get_data_for_form

  end

  def find_to_station_other_unloads # finds to station
    
    station_code = params[:station_code]
    @to_station = params[:to_station_id]
    to_station_code_id = Station.where(code: station_code).pluck(:id)
    @stn = LoadUnload.find_by(station_id: to_station_code_id)? true : false
    # @stn = Station.find_by(code: station_code)? true : false
        
      respond_to do |format|
        format.js
      end
    
  end

  def find_from_station_other_unloads

    from_station_code = params[:from_station_code]
    @from_station = params[:from_station_id]
    @stn = Station.find_by(code: from_station_code)? true : false
    
      respond_to do |format|
        format.js
      end
  end

  def delete_other_unload
    delete_other_unload_id = params[:delete_other_unload_id]
    id = delete_other_unload_id.to_i
    RakeUnload.destroy(id)
   
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
