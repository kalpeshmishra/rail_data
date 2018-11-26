class Admin::GetsUnloadsController < ApplicationController
  layout "admin/application"

  def index
    # @gets_unloads = RakeUnload.all.where(:form_status => "GETS")
  end
  

  def show
    
  end

  def new
    data = params[:data].to_date if params[:data].present?
    data = Date.today if data.blank?
    @gets_unloads = RakeUnload.where(RakeUnload.arel_table[:takenover_date].lteq(data).and(RakeUnload.arel_table[:release_date].eq(data).and(RakeUnload.arel_table[:form_status].eq("GETS"))))
    @gets_unloads += RakeUnload.where(RakeUnload.arel_table[:takenover_date].lteq(data).and(RakeUnload.arel_table[:release_date].eq(nil).and(RakeUnload.arel_table[:form_status].eq("GETS"))))
    @gets_unloads += RakeUnload.where(RakeUnload.arel_table[:takenover_date].lteq(data).and(RakeUnload.arel_table[:release_date].eq("").and(RakeUnload.arel_table[:form_status].eq("GETS"))))
    # @total_rake_unloads = (RakeUnload.where(release_date: data,form_status: "RAKE").pluck(:loaded_unit)).sum
    # @total_other_unloads = (RakeUnload.where(release_date: data,form_status: "OTHER").pluck(:loaded_unit)).sum
    

    get_data_for_form
  end

  def create
    RakeUnload.create_or_update_gets_unload(params)

    data = params[:data].to_date if params[:data].present?
    data = Date.today if data.blank?

    @gets_unloads = RakeUnload.where(RakeUnload.arel_table[:takenover_date].lteq(data).and(RakeUnload.arel_table[:release_date].eq(data).and(RakeUnload.arel_table[:form_status].eq("GETS"))))
    @gets_unloads += RakeUnload.where(RakeUnload.arel_table[:takenover_date].lteq(data).and(RakeUnload.arel_table[:release_date].eq(nil).and(RakeUnload.arel_table[:form_status].eq("GETS"))))
    @gets_unloads += RakeUnload.where(RakeUnload.arel_table[:takenover_date].lteq(data).and(RakeUnload.arel_table[:release_date].eq("").and(RakeUnload.arel_table[:form_status].eq("GETS"))))
    # # @total_rake_unloads = (RakeUnload.where(release_date: data,form_status: "RAKE").pluck(:loaded_unit)).sum
    # @total_other_unloads = (RakeUnload.where(release_date: data,form_status: "OTHER").pluck(:loaded_unit)).sum
    
    get_data_for_form
  end

  def get_data_for_form
    # @from_stations = Station.all.map{|station| ["#{station.code}-#{station.name}",station.id]}
    # @to_stations = []
    # LoadUnload.all.each do |load|
    #   station = Station.find(load.station_id) rescue nil
    #   @to_stations << ["#{station.code}-#{station.name}", station.id] if station.present?
    # end 
    @major_commodity = MajorCommodity.all.map{|major|[major.major_commodity,major.id]}
    @wagon_type = WagonType.all.order(wagon_type_code: :asc).map{|wagon| ["#{wagon.wagon_type_code}--#{wagon.wagon_type_desc}",wagon.id]}
    @rake_commodity = {}
    MajorCommodity.all.each do |major|
    rake_commodity_array = major.rake_commodities.map{|rake_commodity| ["#{rake_commodity.rake_commodity_code}-#{rake_commodity.rake_commodity_name}",rake_commodity.id]}
      @rake_commodity[major.id] = {data: rake_commodity_array}
    end
  end

   def find_to_station_gets_unloads # finds to station
    
    station_code = params[:station_code]
    @to_station = params[:to_station_id]
    to_station_code_id = Station.where(code: station_code).pluck(:id)
    @stn = LoadUnload.find_by(station_id: to_station_code_id)? true : false
    # @stn = Station.find_by(code: station_code)? true : false
        
      respond_to do |format|
        format.js
      end
    
  end

  def find_from_station_gets_unloads  # finds from station
    
    from_station_code = params[:from_station_code]
    @from_station = params[:from_station_id]
    @stn = Station.find_by(code: from_station_code)? true : false
    
      respond_to do |format|
        format.js
      end
    
  end  

  def delete_gets_unload
    
    delete_rake_id = params[:delete_rake_id]
    id = delete_rake_id.to_i
    RakeUnload.destroy(id)
    
      respond_to do |format|
        format.js
      end
  end

  def edit
    
  end

  def update
    
  end

  def destroy
    
  end

  
end
