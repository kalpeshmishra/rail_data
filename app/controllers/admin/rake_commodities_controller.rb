class Admin::RakeCommoditiesController < ApplicationController
  before_action :set_rake_commodity, only: ['show', 'edit', 'update', 'destroy']
  layout "admin/application"

  def index
    @rake_commodities = RakeCommodity.includes(:major_commodity)
    @rake_commodities = @rake_commodities.paginate(:page => params[:page] || 1, :per_page =>20)
    respond_to do |format|
      format.html
      format.js 
    end
  end

  def new
    @rake_commodity = RakeCommodity.new
    respond_to do |format|
      format.js 
    end
  end
  

  def create
    if params[:rake_commodity_attachment].present?
      RakeCommodity.set_rake_commodity_upload(params) 
      respond_to do |format|
        format.js
      end
      
    else

      @rake_commodity = RakeCommodity.new(rake_commodity_params)
      @rake_commodity.save if @rake_commodity
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
    @rake_commodity.update_attributes(rake_commodity_params)
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

    def rake_commodity_params
      params.require(:rake_commodity).permit!
    end
    def set_rake_commodity
      @rake_commodity = RakeCommodity.find(params[:id])
    end

end
