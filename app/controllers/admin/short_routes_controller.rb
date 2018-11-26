class Admin::ShortRoutesController < ApplicationController
  before_action :set_short_route, only: ['show','edit','update','destroy']
  layout "admin/application"

  def index
    @short_routes = ShortRoute.all
    @short_routes = @short_routes.paginate(:page => (params[:page] || 1), :per_page => 20)
    respond_to do |format|
      format.html
      format.js 
    end
  end

  def new
    @short_route = ShortRoute.new
    respond_to do |format|
      format.js
    end
    
  end

  def create
    if params[:short_route_attachment].present?
      ShortRoute.set_short_route_upload(params) 
      respond_to do |format|
        format.js
      end
      
    else

      @short_route = ShortRoute.new(short_route_params)
      @short_route.save if @short_route
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
    @short_route.update_attributes(short_route_params)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @short_route.delete if @short_route
    respond_to do |format|
      format.js
    end
  end

  private

  def short_route_params
    params.require(:short_route).permit!
  end

  def set_short_route
    @short_route = ShortRoute.find(params[:id])
  end
  
end
