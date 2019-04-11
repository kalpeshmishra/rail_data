class Admin::LoadInterchangesController < ApplicationController
	layout "admin/application"

	def index
		
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

    @load_interchange.each do |data|
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
      
    @load_interchange_summary = temp 
  end
end
