class Admin::MonthRakeLoadsController < ApplicationController
	layout "admin/application"

	def index
		
	end

	def create
		
		# if params[:month_rake_load].present? || params[:month_phasewise_rake_load].present?
  #     MonthRakeLoad.set_month_rake_load_upload(params) 
      
  #     respond_to do |format|
  #       format.js
  #     end
    # end
   	selected_month = params[:month_list]
   	from_date = selected_month.to_date.beginning_of_month  
   	to_date = selected_month.to_date.end_of_month  
    
    loading_data = RakeLoad.where(release_date: from_date..to_date)
    data_hash = {}
    i = 100
    if loading_data.present? && i ==111
	    loading_data.each do |data|
	    	data_hash[data.load_unload_id] = {} if data_hash.blank?
	    	# binding.pry if i<200
	    	if data_hash[data.load_unload_id][data.major_commodity_id].blank? 
	    		data_hash[data.load_unload_id].merge!(data.major_commodity_id => {})
	    	else
	    		if data_hash[data.load_unload_id][data.major_commodity_id][data.wagon_type_id].blank?
	    			data_hash[data.load_unload_id][data.major_commodity_id].merge!(data.wagon_type_id => {})	
	    		else

	    		end
	    	end	
	    	
	    end
    end


	end



end
