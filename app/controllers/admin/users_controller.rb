class Admin::UsersController < ApplicationController
  before_action :set_user, only: ['show','edit','update','destroy']
  layout "admin/application"

  def index
    @users = User.all
    @users = @users.paginate(:page => (params[:page] || 1), :per_page => 20)
    respond_to do |format|
      format.html
      format.js 
    end
  end

  def new
    @user = User.new
    respond_to do |format|
      format.js
    end
    
  end

  
  def create
    if params[:user_attachment].present?
      User.set_user_upload(params) 
      respond_to do |format|
        format.js
      end
      
    else

      @user = User.new(user_params)
      
      @user.save if @user
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
    @user.update_attributes(user_params)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @user.delete if @user
    respond_to do |format|
      format.js
    end
  end

  private

  def user_params
    params.require(:user).permit!
  end

  def set_user
    @user = User.find(params[:id])
  end
end
