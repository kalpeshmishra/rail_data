class Admin::UserRolesController < ApplicationController
  # before_action :set_user_role, only: ['show','edit','update','destroy']
  layout "admin/application"



    # @user_roles = UserRole.where(id: @get_user_id)
 
  def edit
     
    respond_to do |format|
      format.js
    end
  end

  def update
    # @user.update_attributes(user_params)
    respond_to do |format|
      format.js
    end
  end


  private

  def user_role_params
    params.require(:user).permit!
  end

  # def set_user_role
  #   @user_role = UserRole.where(id: params[:id])
  # end

end
