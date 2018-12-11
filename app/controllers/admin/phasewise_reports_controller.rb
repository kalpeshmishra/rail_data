class Admin::PhasewiseReportsController < ApplicationController
	layout "admin/application"
	def index
		from_date = params[:from_date].to_date if params[:from_date].present?
		to_date = params[:to_date].to_date if params[:to_date].present?
		
		from_date = Date.today if from_date.blank?
		to_date = Date.today if to_date.blank?
				
		adi_area = Area.find_by(area_code: "ADI")
	 	gimb_area = Area.find_by(area_code: "GIMB")
	 	adi_load_unload = LoadUnload.where(area_id: adi_area.id)
	 	gimb_load_unload = LoadUnload.where(area_id: gimb_area.id)

	 	#Rake loading phasewsie code starts
		rake_load_data = RakeLoad.where(release_date: from_date..to_date,rakeform_otherform: "R")

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
		# binding.pry
		#Rake loading phasewsie code Ends

		#Rake un-loading phasewsie code starts
		rake_unload_data = RakeUnload.where(release_date: from_date..to_date,form_status: "RAKE")
		
		rake_unload_adi = adi_load_unload.map{|load| load.rake_unloads.map{|rake| rake if rake_unload_data.include?(rake)}}.flatten.compact
 		rake_unload_gimb = gimb_load_unload.map{|load| load.rake_unloads.map{|rake| rake if rake_unload_data.include?(rake)}}.flatten.compact
		
 		temp_unloading = rake_unload_data.group_by { |rake| rake.load_unload_id }
 		adi_temp_unloading = rake_unload_adi.group_by { |rake| rake.load_unload_id } if rake_unload_adi.present?
		gimb_temp_unloading = rake_unload_gimb.group_by { |rake| rake.load_unload_id } if rake_unload_gimb.present?
	
		@adi_unloading_rake = rake_unload_adi.map{|x|x.rake_count}.compact.sum
		@gimb_unloading_rake =rake_unload_gimb.map{|x|x.rake_count}.compact.sum
		@total_unloading_rake = @adi_unloading_rake + @gimb_unloading_rake

		@adi_unloaded_unit = rake_unload_adi.map{|x|x.loaded_unit}.compact.sum
		@gimb_unloaded_unit = rake_unload_gimb.map{|x|x.loaded_unit}.compact.sum
		@total_unloaded_unit= @adi_unloaded_unit + @gimb_unloaded_unit

		@rake_and_unload_unit_data= {}
		@rake_and_unload_unit_data_for_adi = {}
		@rake_and_unload_unit_data_for_gimb = {}
		
		@rake_and_unload_unit_data = RakeLoad.get_phasewise_data(temp_unloading) if temp_unloading.present?
		@rake_and_unload_unit_data_for_adi = RakeLoad.get_phasewise_data(adi_temp_unloading) if adi_temp_unloading.present?
		@rake_and_unload_unit_data_for_gimb = RakeLoad.get_phasewise_data(gimb_temp_unloading) if gimb_temp_unloading.present?
		
		#Rake un-loading phasewsie code Ends
		
		#Total Division phase-wise starts
		
		total_temp = {}
		total_temp.merge!(temp) if temp.present?
		total_temp.merge!(temp_unloading){|key,oldval,newval| [*oldval].to_a + [*newval].to_a } if temp_unloading.present?
		@total_division_phasewise_data = RakeLoad.get_phasewise_data(total_temp) if total_temp.present?
		@total_division_phasewise_data = {} if total_temp.empty?
		# binding.pry
		@total_division_rake = @total_division_phasewise_data.map{|k,v|v[:rake_count]}.compact.sum
		@total_division_unit = @total_division_phasewise_data.map{|k,v|v[:loaded_unit]}.compact.sum

		total_adi ={}
		total_adi.merge!(adi_temp) if adi_temp.present?
		total_adi.merge!(adi_temp_unloading){|key,oldval,newval| [*oldval].to_a + [*newval].to_a } if adi_temp_unloading.present?
		@total_adi_phasewise_data = RakeLoad.get_phasewise_data(total_adi) if total_adi.present?
		@total_adi_phasewise_data = {} if total_adi.empty?		
		@total_adi_rake = @total_adi_phasewise_data.map{|k,v|v[:rake_count]}.compact.sum
		@total_adi_unit = @total_adi_phasewise_data.map{|k,v|v[:loaded_unit]}.compact.sum



		total_gimb ={}
		total_gimb.merge!(gimb_temp) if gimb_temp.present?
		total_gimb.merge!(gimb_temp_unloading){|key,oldval,newval| [*oldval].to_a + [*newval].to_a } if gimb_temp_unloading.present?
		@total_gimb_phasewise_data = RakeLoad.get_phasewise_data(total_gimb) if total_gimb.present?
		@total_gimb_phasewise_data = {} if total_gimb.empty?
		@total_gimb_rake = @total_gimb_phasewise_data.map{|k,v|v[:rake_count]}.compact.sum
		@total_gimb_unit = @total_gimb_phasewise_data.map{|k,v|v[:loaded_unit]}.compact.sum

		# binding.pry
		#Total Division phase-wise ends
		
		#Stationwise Start
		data_hash = {}
		rake_load_adi.each do |data|
		release_date = data.release_date.strftime("%d-%m-%Y")
		load_unload_code = LoadUnload.find(data.load_unload_id).station.code

			if data.release_date.present?
				if data_hash[release_date].present?

				 if data_hash[release_date].keys.include?(load_unload_code)
				   data_hash[release_date][load_unload_code] << data
				 else
				   data_hash[release_date].merge!("#{load_unload_code}" => [data])
				 end
				else
				 data_hash[release_date] = {}
				 data_hash[release_date].merge!("#{load_unload_code}" => [data])
				end
			end
		end

		@rake_load_stationwise = data_hash.sort.to_h
		@loading_header = @rake_load_stationwise.map{|k,v|v.keys}.flatten.compact.uniq.sort
		
		# temp = Array.new(30, 0)  
		# header_hash = @loading_header.zip(temp).to_h

		# temp_rake = @rake_load_stationwise
		# temp_rake.each do |key,value|
		# 	temp_rake[key].merge!(header_hash){|key,oldval,newval| [*oldval].to_a + [*newval].to_a }
		# end
			
		# @rake_load_stationwise = temp_rake.sort.to_h
		
		#stationwise Ends
		
	end

	def show
	end
end