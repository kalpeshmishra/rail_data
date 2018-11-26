class Admin::LoadUnloadsController < ApplicationController
  before_action :set_load_unload, only: ['show', 'edit', 'update', 'destroy']
  layout "admin/application"
  
  def index
    @load_unloads = LoadUnload.all
    @load_unloads = @load_unloads.paginate(:page => params[:page] || 1, :per_page => 20)
    respond_to do |format|
      format.html
      format.js 
    end
  end

  def new
    @load_unload = LoadUnload.new
    respond_to do |format|
      format.js
    end
  end

  def create
    if params[:load_unload_attachment].present?
      LoadUnload.set_load_unload_upload(params) 
      respond_to do |format|
        format.js
      end
    else
      @load_unload = LoadUnload.new(load_unload_params)
      @load_unload.save if @load_unload
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
    @load_unload.update_attributes(load_unload_params)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @load_unload.delete if @load_unload
    respond_to do |format|
      format.js
    end
  end

private

  def load_unload_params
    params.require(:load_unload).permit!
  end

  def set_load_unload
    @load_unload = LoadUnload.find(params[:id])
  end
end
