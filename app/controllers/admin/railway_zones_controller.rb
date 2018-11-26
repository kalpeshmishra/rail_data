class Admin::RailwayZonesController < ApplicationController
	before_action :set_railway_zone, only: ['show','edit','update','destroy']
  layout "admin/application"
	
	def index
    @railway_zones = RailwayZone.all
    @railway_zones = @railway_zones.paginate(:page => (params[:page] || 1), :per_page => 10)
		respond_to do |format|
      format.html
      format.js 
    end
	end

	def new
    @railway_zone = RailwayZone.new
		respond_to do |format|
      format.js
    end
	end

	def create
    if params[:railway_zone_attachment].present?
      RailwayZone.set_railway_zone_upload(params) 
      respond_to do |format|
        format.js
      end
    else
      @railway_zone = RailwayZone.new(railway_zone_params)
      @railway_zone.save if @railway_zone
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
    @railway_zone.update_attributes(railway_zone_params)
		respond_to do |format|
      format.js
    end
	end

	def destroy
    @railway_zone.delete if @railway_zone
		respond_to do |format|
      format.js
    end
	end

  private

  def railway_zone_params
    params.require(:railway_zone).permit!
  end
  # def railway_zone_params
  #   params.require(:railway_zone).permit(:name, :code, :zone_headquarter, :state_id)
  # end


  def set_railway_zone
    @railway_zone = RailwayZone.find(params[:id])
  end

end
