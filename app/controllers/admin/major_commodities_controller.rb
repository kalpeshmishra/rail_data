class Admin::MajorCommoditiesController < ApplicationController
  before_action :set_major_commodity, only: ['show','edit','update','destroy']
  layout "admin/application"

  def index
    @major_commodities = MajorCommodity.all
    @major_commodities = @major_commodities.paginate(:page => (params[:page] || 1), :per_page => 20)
    respond_to do |format|
      format.html
      format.js 
    end
  end

  def new
    @major_commodity = MajorCommodity.new
    respond_to do |format|
      format.js
    end
    
  end

  def create
    if params[:major_commodity_attachment].present?
      MajorCommodity.set_major_commodity_upload(params) 
      respond_to do |format|
        format.js
      end
      
    else

      @major_commodity = MajorCommodity.new(major_commodity_params)
      @major_commodity.save if @major_commodity
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
    @major_commodity.update_attributes(major_commodity_params)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @major_commodity.delete if @major_commodity
    respond_to do |format|
      format.js
    end
  end

  private

  def major_commodity_params
    params.require(:major_commodity).permit!
  end

  def set_major_commodity
    @major_commodity = MajorCommodity.find(params[:id])
  end

end
