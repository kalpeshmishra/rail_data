class Admin::CrackRakesController < ApplicationController
	layout "admin/application"

	def index
		from_date = params[:from_date].to_date if params[:from_date].present?
		to_date = params[:to_date].to_date if params[:to_date].present?
		
		from_date = Date.today if from_date.blank?
		to_date = Date.today if to_date.blank?

		@adi_crack_data = CrackRake.where(departure_date: from_date..to_date)
	end

	def new
		data = params[:data].to_date if params[:data].present?
    data = Date.today if data.blank?
		@crack_rakes = CrackRake.where(departure_date: data)
	end

	def create
		CrackRake.create_or_update_crack_rake(params)
		data = params[:date].to_date if params[:date].present?
    data = Date.today if data.blank?
		@crack_rakes = CrackRake.where(departure_date: data)
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
