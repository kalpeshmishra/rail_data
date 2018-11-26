class Admin::StationsController < ApplicationController
	before_action :set_station, only: ['show', 'edit', 'update', 'destroy']
  layout "admin/application"

	def index
    @stations = Station.all
    @stations = @stations.paginate(:page => params[:page] || 1, :per_page => 20)
		respond_to do |format|
      format.html
      format.js 
    end
	end

	def new
    @station = Station.new
		respond_to do |format|
      format.js
    end
	end

	def create
    if params[:station_attachment].present?
      Station.set_station_upload(params) 
      
      respond_to do |format|
        format.js
      end
      
    else
      @station = Station.new(station_params)
      @station.save if @station
  		respond_to do |format|
        format.js
      end
    end
	end

	def show

		respond_to do |format|
      format.js
    end
	end

	def edit

		respond_to do |format|
      format.js
    end
	end

	def update
    @station.update_attributes(station_params)
		respond_to do |format|
      format.js
    end
	end

	def destroy

		respond_to do |format|
      format.js
    end
	end

  private

    def station_params
      params.require(:station).permit!
    end
    def set_station
      @station = Station.find(params[:id])
    end

end
