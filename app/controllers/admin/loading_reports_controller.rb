class Admin::LoadingReportsController < ApplicationController
	layout "admin/application"

	def index
		data = params[:data].to_date if params[:data].present?
    data = Date.today if data.blank?

    @rake_loads = RakeLoad.where(RakeLoad.arel_table[:arrival_date].lteq(data).and(RakeLoad.arel_table[:release_date].eq(data)))
    @rake_loads += RakeLoad.where(RakeLoad.arel_table[:arrival_date].lteq(data).and(RakeLoad.arel_table[:release_date].eq(nil)))
    @rake_loads += RakeLoad.where(RakeLoad.arel_table[:arrival_date].lteq(data).and(RakeLoad.arel_table[:release_date].eq("")))
    @rake_loads += RakeLoad.where(RakeLoad.arel_table[:arrival_date].eq(nil).and(RakeLoad.arel_table[:release_date].eq(data)))
    @rake_loads += RakeLoad.where(RakeLoad.arel_table[:arrival_date].eq(nil).and(RakeLoad.arel_table[:release_date].eq(nil)))
    
    adi_area_loads =[]
    gimb_area_loads =[]

    adi_unit = 0
    gimb_unit = 0
    @rake_loads.each do |rake_load|
    	rake_area =  rake_load.load_unload.station.area.area_code rescue nil
    	if rake_area == "ADI"
    		adi_area_loads << rake_load
    		adi_unit = adi_unit + rake_load.loaded_unit
    	elsif rake_area == "GIMB"
    		gimb_area_loads << rake_load
    		gimb_unit = gimb_unit + rake_load.loaded_unit
    	end
    end
    @adi_loads = adi_area_loads
    @gimb_loads = gimb_area_loads
    
    @total_adi_loads = adi_unit
		@total_gimb_loads = gimb_unit
    @total_rake_loads = (RakeLoad.where(release_date: data,rakeform_otherform: "R").pluck(:loaded_unit)).sum
    
  end
  

  def show
    
  end
end
