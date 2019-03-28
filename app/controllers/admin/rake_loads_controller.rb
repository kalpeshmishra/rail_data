class Admin::RakeLoadsController < ApplicationController
  layout "admin/application"

  def index
    data = params[:data].to_date if params[:data].present?
    data = Date.today if data.blank?
    # => (lessthan-lt, greater-gt equal-eq)
    @rake_loads = RakeLoad.where(RakeLoad.arel_table[:arrival_date].lteq(data).and(RakeLoad.arel_table[:release_date].eq(data)))
    @rake_loads += RakeLoad.where(RakeLoad.arel_table[:arrival_date].lteq(data).and(RakeLoad.arel_table[:release_date].eq(nil)))
    @rake_loads += RakeLoad.where(RakeLoad.arel_table[:arrival_date].lteq(data).and(RakeLoad.arel_table[:release_date].eq("")))
    @rake_loads += RakeLoad.where(RakeLoad.arel_table[:arrival_date].eq(nil).and(RakeLoad.arel_table[:release_date].eq(data)))
    @rake_loads += RakeLoad.where(RakeLoad.arel_table[:arrival_date].eq(nil).and(RakeLoad.arel_table[:release_date].eq(nil)))
    current_user_rake_load = []
      @rake_loads.each do |rake_load|
        rake_area =  rake_load.load_unload.station.area.area_code rescue nil
        current_user_area = current_user.area rescue nil
        
        if rake_area == current_user_area
          current_user_rake_load << rake_load
        end
      end
    @rake_loads = current_user_rake_load

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
    
    @total_other_loads = (RakeLoad.where(release_date: data,rakeform_otherform: "O").pluck(:loaded_unit)).sum

    # @rake_loads = @rake_loads.paginate(:page => params[:page] || 1, :per_page => 20)
  end
  

  def show
    
  end

  def new
    
    data = params[:data].to_date if params[:data].present?
    data = Date.today if data.blank?
    # => (lessthan-lt, greater-gt equal-eq)
    @rake_loads = RakeLoad.where(RakeLoad.arel_table[:arrival_date].lteq(data).and(RakeLoad.arel_table[:release_date].eq(data).and(RakeLoad.arel_table[:rakeform_otherform].eq("R"))))
    @rake_loads += RakeLoad.where(RakeLoad.arel_table[:arrival_date].lteq(data).and(RakeLoad.arel_table[:release_date].eq(nil).and(RakeLoad.arel_table[:rakeform_otherform].eq("R"))))
    @rake_loads += RakeLoad.where(RakeLoad.arel_table[:arrival_date].lteq(data).and(RakeLoad.arel_table[:release_date].eq("").and(RakeLoad.arel_table[:rakeform_otherform].eq("R"))))
    @rake_loads += RakeLoad.where(RakeLoad.arel_table[:arrival_date].eq(nil).and(RakeLoad.arel_table[:rakeform_otherform].eq("R")))
    @rake_loads += RakeLoad.where(RakeLoad.arel_table[:arrival_date].eq("").and(RakeLoad.arel_table[:rakeform_otherform].eq("R")))
    
    get_user_area_wise_data(data)
    get_data_for_form
  
  end

  def create
    RakeLoad.create_or_update_rake_load(params)
    data = params["date"].to_date if params["date"].present?
    data = Date.today if data.blank?
    @rake_loads = RakeLoad.where(RakeLoad.arel_table[:arrival_date].lteq(data).and(RakeLoad.arel_table[:release_date].eq(data).and(RakeLoad.arel_table[:rakeform_otherform].eq("R"))))
    @rake_loads += RakeLoad.where(RakeLoad.arel_table[:arrival_date].lteq(data).and(RakeLoad.arel_table[:release_date].eq(nil).and(RakeLoad.arel_table[:rakeform_otherform].eq("R"))))
    @rake_loads += RakeLoad.where(RakeLoad.arel_table[:arrival_date].lteq(data).and(RakeLoad.arel_table[:release_date].eq("").and(RakeLoad.arel_table[:rakeform_otherform].eq("R"))))
    @rake_loads += RakeLoad.where(RakeLoad.arel_table[:arrival_date].eq(nil).and(RakeLoad.arel_table[:rakeform_otherform].eq("R")))
    @rake_loads += RakeLoad.where(RakeLoad.arel_table[:arrival_date].eq("").and(RakeLoad.arel_table[:rakeform_otherform].eq("R")))
    
    get_user_area_wise_data(data)
    get_data_for_form
  
  end

  def get_user_area_wise_data(data)
     current_user_rake_load = []
      @rake_loads.each do |rake_load|
        rake_area =  rake_load.load_unload.station.area.area_code rescue nil
        current_user_area = current_user.area rescue nil
        
        if rake_area == current_user_area
          current_user_rake_load << rake_load
        end
      end
    @rake_loads = current_user_rake_load

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
  end

  

  def get_user_area
    user_area = current_user.area
    if user_area.present? 
      @user_area_id = Area.where(area_code: user_area).pluck(:id)
    end 
    
  end

  def get_data_for_form
    # @from_stations = []
    # LoadUnload.all.each do |load|
    #   station = Station.find(load.station_id) rescue nil
    #   @from_stations << ["#{station.code}-#{station.name}", station.id] if station.present?
    # end  
    # @to_stations =  get_all_station #Station.all.map{|station| [station.code,station.id]}
    @major_commodity = MajorCommodity.all.map{|major|["#{major.major_commodity}--#{major.name}",major.id]}
    @wagon_type = WagonType.all.order(wagon_type_code: :asc).map{|wagon| ["#{wagon.wagon_type_code}--#{wagon.wagon_type_desc}",wagon.id]}
    @rake_commodity = {}
    MajorCommodity.all.each do |major|
    rake_commodity_array = major.rake_commodities.map{|rake_commodity| ["#{rake_commodity.rake_commodity_code}-#{rake_commodity.rake_commodity_name}",rake_commodity.id]}
      @rake_commodity[major.id] = {data: rake_commodity_array}
    end
  end 

  # def get_all_station
  #   p = ActiveRecord::Base.establish_connection
  #   p.class
  #   c = p.connection
  #   results = c.execute('select code,id from stations;')
  #   results.class
  #   results.each do |result|
  #     p result
  #   end   
  # end 

  def find_station # finds to station (Unloading station)
    
    station_code = params[:station_code]
    @to_station = params[:to_station_id]
    @stn = Station.find_by(code: station_code)? true : false
        
      respond_to do |format|
        format.js
      end
    
  end

  def find_from_station  # Find from station (Loading station)

    
    get_user_area

    from_station_code = params[:from_station_code]
    @from_station = params[:from_station_id]
    from_station_code_id = Station.where(code: from_station_code).pluck(:id)
    @stn = LoadUnload.find_by(station_id: from_station_code_id, area_id: @user_area_id)? true : false

        
      respond_to do |format|
        format.js
      end
    
  end

  def delete_rake_load
    delete_rake_id = params[:delete_rake_id]
    id = delete_rake_id.to_i
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
