class Admin::LoadInterchangesController < ApplicationController
	layout "admin/application"

	def index
      from_date = params[:from_date].to_date if params[:from_date].present?
      to_date = params[:to_date].to_date if params[:to_date].present?
      
      from_date = Date.today if from_date.blank?
      to_date = Date.today if to_date.blank?
      interchange_load_data = LoadInterchange.where(interchange_date: from_date..to_date)
    
    if params["is_date_select"].present?
      stock_list = []
      interchange_load_data.each do |ic_load|
        stock_list << [ic_load.wagon_type.wagon_type_code,ic_load.wagon_type_id ]
      end
      @load_interchange_stock_list = stock_list.compact.uniq.sort
    end

    if params["is_data_filter"].present? 
      select_wagon_ids = params[:selected_stock].split(',').map{|x|x.to_i}.delete_if {|x| x ==0}
      select_interchange_point = params[:selected_interchange].split(',').map{|x|x}.delete_if {|x| x =="multiselect-all"}

      select_interchange_load_data = interchange_load_data.where(wagon_type_id: select_wagon_ids,interchange_point: select_interchange_point)

      data_type = "rake"
      rakewise_load_interchange_data_hash = LoadInterchange.get_load_interchange_data(select_interchange_load_data,select_interchange_point,data_type) if select_interchange_load_data.present?
      data_type = "unit"
      unitwise_load_interchange_data_hash = LoadInterchange.get_load_interchange_data(select_interchange_load_data,select_interchange_point,data_type) if select_interchange_load_data.present?

      @rakewise_load_interchange_data = rakewise_load_interchange_data_hash
      @unitwise_load_interchange_data = unitwise_load_interchange_data_hash
      
    end
      
	end

	def show
    
  end

  def new
    get_data_for_form
  end

  def create
  	LoadInterchange.create_or_update_load_interchange(params)
  	get_data_for_form

  end


  def get_data_for_form
 		@wagon_type = WagonType.all.order(wagon_type_code: :asc).map{|wagon| ["#{wagon.wagon_type_code}-#{wagon.wagon_details_covered_open}",wagon.id]}
  	
  	data = params[:date].to_date if params[:date].present?
    data = Date.today if data.blank?
    interchange_type = params[:interchange_point].split("-")[0] if params[:interchange_point].present?
    interchange_point = params[:interchange_point].split("-")[1] if params[:interchange_point].present?
    @load_interchange = LoadInterchange.where(interchange_date: data,interchange_type: interchange_type,interchange_point: interchange_point)
    
    covered_rake = []
    covered_unit = []
    open_rake = []
    open_unit = []
    loaded_rake = []
    loaded_unit = []
    empty_rake = []
    empty_unit = []
    total_rake = []
    total_unit = []

    @load_interchange.each do |data|
      total_rake << data.rakes
      total_unit << data.units

      if data.stock_details == "Empty"
        empty_rake << data.rakes
        empty_unit << data.units
      else
        loaded_rake << data.rakes
        loaded_unit << data.units
      end

      if WagonType.find(data.wagon_type_id).wagon_details_covered_open == "COVERED"
        covered_rake << data.rakes
        covered_unit << data.units
      else
        open_rake << data.rakes
        open_unit << data.units
      end

    end
      temp = {}
      temp["covered_rake"] = covered_rake.reject(&:blank?).sum
      temp["covered_unit"] = covered_unit.reject(&:blank?).sum
      temp["open_rake"] = open_rake.reject(&:blank?).sum
      temp["open_unit"] = open_unit.reject(&:blank?).sum
      temp["loaded_rake"] = loaded_rake.reject(&:blank?).sum
      temp["loaded_unit"] = loaded_unit.reject(&:blank?).sum
      temp["empty_rake"] = empty_rake.reject(&:blank?).sum
      temp["empty_unit"] = empty_unit.reject(&:blank?).sum
      temp["total_rake"] = total_rake.reject(&:blank?).sum
      temp["total_unit"] = total_unit.reject(&:blank?).sum
      
    @load_interchange_summary = temp 
  end

  def delete_load_interchange
    delete_load_interchange_id = params[:delete_load_interchange_id]
    id = delete_load_interchange_id.to_i
    LoadInterchange.destroy(id)
    get_data_for_form
   
    respond_to do |format|
      format.js
    end

  end

end
