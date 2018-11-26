class Admin::WagonTypesController < ApplicationController
  before_action :set_wagon_type, only: ['show', 'edit', 'update', 'destroy']
  layout "admin/application"

  def index
    @wagon_types = WagonType.all
    @wagon_types = @wagon_types.paginate(:page => params[:page] || 1, :per_page => 10)
    respond_to do |format|
      format.html
      format.js 
    end
  end

  def new
    @wagon_type = WagonType.new
    respond_to do |format|
      format.js 
    end
  end

  def create
    if params[:wagon_type_attachment].present?
      WagonType.set_wagon_type_upload(params) 
      respond_to do |format|
        format.js
      end
      
    else
      @wagon_type = WagonType.new(wagon_type_params)
      @wagon_type.save if @wagon_type
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
    @wagon_type.update_attributes(wagon_type_params)
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

    def wagon_type_params
      params.require(:wagon_type).permit!
    end
    def set_wagon_type
      @wagon_type = WagonType.find(params[:id])
    end
end
