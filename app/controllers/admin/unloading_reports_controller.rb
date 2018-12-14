class Admin::UnloadingReportsController < ApplicationController
	layout "admin/application"

	def index
		data = params[:data].to_date if params[:data].present?
    data = Date.today if data.blank?
    # binding.pry
    @rake_unloads = RakeUnload.where(RakeUnload.arel_table[:arrival_date].lteq(data).and(RakeUnload.arel_table[:release_date].eq(data)))
    @rake_unloads += RakeUnload.where(RakeUnload.arel_table[:arrival_date].lteq(data).and(RakeUnload.arel_table[:release_date].eq(nil)))
    @rake_unloads += RakeUnload.where(RakeUnload.arel_table[:arrival_date].lteq(data).and(RakeUnload.arel_table[:release_date].eq("")))
    @rake_unloads += RakeUnload.where(RakeUnload.arel_table[:arrival_date].eq(nil).and(RakeUnload.arel_table[:release_date].eq(data)))
    @rake_unloads += RakeUnload.where(RakeUnload.arel_table[:arrival_date].eq(nil).and(RakeUnload.arel_table[:release_date].eq(nil)))
    
    adi_area_unloads =[]
    gimb_area_unloads =[]

    adi_unit = 0
    gimb_unit = 0
    @rake_unloads.each do |rake_unload|
    	rake_area =  rake_unload.load_unload.station.area.area_code rescue nil
    	if rake_area == "ADI"
    		adi_area_unloads << rake_unload
    		adi_unit = adi_unit + rake_unload.loaded_unit
    	elsif rake_area == "GIMB"
    		gimb_area_unloads << rake_unload
    		gimb_unit = gimb_unit + rake_unload.loaded_unit
    	end
    end
    @adi_unloads = adi_area_unloads.sort_by(&:load_unload_id)
    @gimb_unloads = gimb_area_unloads
    
    @total_adi_unloads = adi_unit
		@total_gimb_unloads = gimb_unit
    @total_rake_unloads = adi_unit + gimb_unit 
    
  end
  

  def show
    
  end
end
