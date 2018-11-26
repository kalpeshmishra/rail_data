class Admin::AreasController < ApplicationController
  before_action :set_area, only: ['show', 'edit', 'update', 'destroy']
  layout "admin/application"
  
  def index
    @areas = Area.all
    @areas = @areas.paginate(:page => params[:page] || 1, :per_page => 20)
    respond_to do |format|
      format.html
      format.js 
    end
  end

  def get_division
    zone_id = params[:zone_id].to_i
    @divisions = Division.where(railway_zone_id: zone_id).map{|div|[div.name,div.id]}
    respond_to do |format|
      format.js
    end
  end

  def new
    @area = Area.new
    respond_to do |format|
      format.js
    end
  end

  def create
    if params[:area_attachment].present?
      Area.set_area_upload(params) 
      
      respond_to do |format|
        format.js
      end
      
    else
      @area = Area.new(area_params)
      @area.save if @area
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
    @area.update_attributes(area_params)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @area.delete if @area
    respond_to do |format|
      format.js
    end
  end

private

  def area_params
    params.require(:area).permit!
  end

  def set_area
    @area = Area.find(params[:id])
  end
end
