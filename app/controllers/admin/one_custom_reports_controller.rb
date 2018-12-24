class Admin::OneCustomReportsController < ApplicationController
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
			commodity_list << [rake_load.major_commodity.major_commodity, rake_load.major_commodity.id]
		end
		@one_custom_commodity_list = commodity_list.compact.uniq.sort

		if params[:is_data_filter].present?
			major_commodity_ids = params[:selected_commodity].split(',').map{|x|x.to_i}.delete_if {|x| x ==0}
			major_commodity_codes = major_commodity_ids.map{|x| MajorCommodity.find(x).major_commodity}
						
			
		end

		# binding.pry
	end

	def show
	end


end
