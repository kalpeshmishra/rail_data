class Admin::PhasewiseReportsController < ApplicationController
	layout "admin/application"
	def index
		from_date = params[:from_date].to_date if params[:from_date].present?
		to_date = params[:to_date].to_date if params[:to_date].present?
		
		from_date = Date.today if from_date.blank?
		to_date = Date.today if to_date.blank?
				
		rake_load_data = RakeLoad.where(release_date: from_date..to_date,rakeform_otherform: "R")
		
		adi_area = Area.find_by(area_code: "ADI")
	 	gimb_area = Area.find_by(area_code: "GIMB")
	 	adi_load_unload = LoadUnload.where(area_id: adi_area.id)
	 	gimb_load_unload = LoadUnload.where(area_id: gimb_area.id)

	 	rake_load_adi = adi_load_unload.map{|load| load.rake_loads.map{|rake| rake if rake_load_data.include?(rake)}}.flatten.compact
 		rake_load_gimb = gimb_load_unload.map{|load| load.rake_loads.map{|rake| rake if rake_load_data.include?(rake)}}.flatten.compact
		
 		temp = rake_load_data.group_by { |rake| rake.load_unload_id }
 		adi_temp = rake_load_adi.group_by { |rake| rake.load_unload_id } if rake_load_adi.present?
		gimb_temp = rake_load_gimb.group_by { |rake| rake.load_unload_id } if rake_load_gimb.present?

		
		@adi_rake = rake_load_adi.map{|x|x.rake_count}.compact.sum
		@gimb_rake =rake_load_gimb.map{|x|x.rake_count}.compact.sum
		@total_rake = @adi_rake + @gimb_rake

		@adi_loaded_unit = rake_load_adi.map{|x|x.loaded_unit}.compact.sum
		@gimb_loaded_unit = rake_load_gimb.map{|x|x.loaded_unit}.compact.sum
		@total_loaded_unit= @adi_loaded_unit + @gimb_loaded_unit
		
		# rake_count = {}
		# loaded_unit = {}
		@rake_and_load_unit_data= {}
		@rake_and_load_unit_data_for_adi = {}
		@rake_and_load_unit_data_for_gimb = {}
		
		@rake_and_load_unit_data = RakeLoad.get_phasewise_data(temp) if temp.present?
		@rake_and_load_unit_data_for_adi = RakeLoad.get_phasewise_data(adi_temp) if adi_temp.present?
		@rake_and_load_unit_data_for_gimb = RakeLoad.get_phasewise_data(gimb_temp) if gimb_temp.present?
	
	end

	def show
	end
end