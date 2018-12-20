class Admin::CustomReportsController < ApplicationController
  layout "admin/application"
  def index
    from_date = params[:from_date].to_date if params[:from_date].present?
		to_date = params[:to_date].to_date if params[:to_date].present?
		
		from_date = Date.today if from_date.blank?
		to_date = Date.today if to_date.blank?

		station_list = []
		commodity_list = []
		rake_load_data = RakeLoad.where(release_date: from_date..to_date)
		rake_load_data.each do |rake_load|
			station_list << [rake_load.load_unload.station.code,rake_load.load_unload_id ]
			commodity_list << [rake_load.major_commodity.major_commodity, rake_load.major_commodity.id]
		end
		@custom_station_list = station_list.compact.uniq 
		@custom_commodity_list = commodity_list.compact.uniq.sort
			
		# binding.pry

  end

  def show
    
  end
end
