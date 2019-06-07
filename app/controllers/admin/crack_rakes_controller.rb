class Admin::CrackRakesController < ApplicationController
	layout "admin/application"

	def index
		
	end

	def new
		data = params[:data].to_date if params[:data].present?
    data = Date.today if data.blank?
		@crack_rakes = CrackRake.where(departure_date: data)
	end

	def create
		CrackRake.create_or_update_crack_rake(params)
		data = params[:data].to_date if params[:data].present?
    data = Date.today if data.blank?
		@crack_rakes = CrackRake.where(departure_date: data)
		# binding.pry
	end

	def delete_crack_rake
    delete_crack_rake_id = params[:delete_crack_rake_id]
    id = delete_crack_rake_id.to_i
    CrackRake.destroy(id)
    
      respond_to do |format|
        format.js
      end
  end

end
