class Admin::DivisionsController < ApplicationController
	before_action :set_division, only: ['show', 'edit', 'update', 'destroy']
  layout "admin/application"
	
	def index
    @divisions = Division.includes(:railway_zone)
    @divisions = @divisions.paginate(:page => params[:page] || 1, :per_page => 20)
		respond_to do |format|
      format.html
      format.js 
    end
	end

  

	def new
    @division = Division.new
		respond_to do |format|
      format.js
    end
	end

	def create
    if params[:division_attachment].present?
      Division.set_division_upload(params) 
      
      respond_to do |format|
        format.js
      end
      
    else
      @division = Division.new(division_params)
      @division.save if @division
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

  def import_export

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
    @division.update_attributes(division_params)
		respond_to do |format|
      format.js
    end
	end

	def destroy
    @division.delete if @division
		respond_to do |format|
      format.js
    end
	end

private

  def division_params
    params.require(:division).permit!
  end

  def set_division
    @division = Division.find(params[:id])
  end
  
end
