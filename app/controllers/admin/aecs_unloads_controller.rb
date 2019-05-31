class Admin::AecsUnloadsController < ApplicationController
  layout "admin/application"

  def index
    # @aecs_unloads = RakeUnload.all.where(:form_status => "AECS")
  end
  

  def show
    
  end

  def new
    data = params[:data].to_date if params[:data].present?
    data = Date.today if data.blank?
    @aecs_unloads = RakeUnload.where(RakeUnload.arel_table[:takenover_date].lteq(data).and(RakeUnload.arel_table[:release_date].eq(data).and(RakeUnload.arel_table[:form_status].eq("AECS"))))
    @aecs_unloads += RakeUnload.where(RakeUnload.arel_table[:takenover_date].lteq(data).and(RakeUnload.arel_table[:release_date].eq(nil).and(RakeUnload.arel_table[:form_status].eq("AECS"))))
    @aecs_unloads += RakeUnload.where(RakeUnload.arel_table[:takenover_date].lteq(data).and(RakeUnload.arel_table[:release_date].eq("").and(RakeUnload.arel_table[:form_status].eq("AECS"))))
    rake_and_unit_array = RakeUnload.where(release_date: data,form_status: "AECS").pluck(:loaded_unit, :rake_count)
    @total_unit_aecs_unloads = rake_and_unit_array.collect(&:first).sum
    @total_rake_aecs_unloads = rake_and_unit_array.collect(&:second).sum

    get_data_for_form
  end

  def create
    RakeUnload.create_or_update_aecs_unload(params)

    data = params["date"].to_date if params["date"].present?
    data = Date.today if data.blank?

    @aecs_unloads = RakeUnload.where(RakeUnload.arel_table[:takenover_date].lteq(data).and(RakeUnload.arel_table[:release_date].eq(data).and(RakeUnload.arel_table[:form_status].eq("AECS"))))
    @aecs_unloads += RakeUnload.where(RakeUnload.arel_table[:takenover_date].lteq(data).and(RakeUnload.arel_table[:release_date].eq(nil).and(RakeUnload.arel_table[:form_status].eq("AECS"))))
    @aecs_unloads += RakeUnload.where(RakeUnload.arel_table[:takenover_date].lteq(data).and(RakeUnload.arel_table[:release_date].eq("").and(RakeUnload.arel_table[:form_status].eq("AECS"))))
    rake_and_unit_array = RakeUnload.where(release_date: data,form_status: "AECS").pluck(:loaded_unit, :rake_count)
    @total_unit_aecs_unloads = rake_and_unit_array.collect(&:first).sum if rake_and_unit_array.present?
    @total_rake_aecs_unloads = rake_and_unit_array.collect(&:second).sum if rake_and_unit_array.present?

    get_data_for_form
  end

  def get_data_for_form
    @major_commodity = MajorCommodity.all.map{|major|[major.major_commodity,major.id]}
    @wagon_type = WagonType.where(is_viewable: true).order(wagon_type_code: :asc).map{|wagon| ["#{wagon.wagon_type_code}--#{wagon.wagon_type_desc}",wagon.id]}
    @rake_commodity = {}
    MajorCommodity.all.each do |major|
    rake_commodity_array = major.rake_commodities.map{|rake_commodity| ["#{rake_commodity.rake_commodity_code}-#{rake_commodity.rake_commodity_name}",rake_commodity.id]}
      @rake_commodity[major.id] = {data: rake_commodity_array}
    end
  end  

   def find_to_station_aecs_unloads # finds to station
    
    station_code = params[:station_code]
    @to_station = params[:to_station_id]
    to_station_code_id = Station.where(code: station_code).pluck(:id)
    @stn = LoadUnload.find_by(station_id: to_station_code_id)? true : false
    # @stn = Station.find_by(code: station_code)? true : false
        
      respond_to do |format|
        format.js
      end
    
  end

  def find_from_station_aecs_unloads  # finds from station
    
    from_station_code = params[:from_station_code]
    @from_station = params[:from_station_id]
    @stn = Station.find_by(code: from_station_code)? true : false
    
      respond_to do |format|
        format.js
      end
    
  end  

  def delete_aecs_unload
    
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
