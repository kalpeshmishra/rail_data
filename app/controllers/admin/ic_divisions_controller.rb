class Admin::IcDivisionsController < ApplicationController
  before_action :set_ic_division, only: ['show','edit','update','destroy']
  layout "admin/application"

  def index
    @ic_divisions = IcDivision.includes(:railway_zone,:division)
    @ic_divisions = @ic_divisions.paginate(:page => (params[:page] || 1), :per_page => 20)
    respond_to do |format|
      format.html
      format.js 
    end
  end

  def new
    @ic_division = IcDivision.new
    respond_to do |format|
      format.js
    end
    
  end

  def create
    if params[:ic_division_attachment].present?
      IcDivision.set_ic_division_upload(params) 
      respond_to do |format|
        format.js
      end
      
    else

      @ic_division = IcDivision.new(ic_division_params)
      @ic_division.save if @ic_division
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
    @ic_division.update_attributes(ic_division_params)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @ic_division.delete if @ic_division
    respond_to do |format|
      format.js
    end
  end

  private

  def ic_division_params
    params.require(:ic_division).permit!
  end

  def set_ic_division
    @ic_division = IcDivision.find(params[:id])
  end
end
