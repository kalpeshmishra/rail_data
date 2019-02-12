class Admin::MonthRakeLoadsController < ApplicationController
	layout "admin/application"

	def index
		
	end

	def create
		
		if params[:month_rake_load].present?
      MonthRakeLoad.set_month_rake_load_upload(params) 
      
      respond_to do |format|
        format.js
      end
    end
    
	end



end
