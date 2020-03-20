class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :authenticate_user!



  def authenticate_admin
    unless (user_signed_in? and current_user.admin?)
      redirect_to root_path
    end
  end

  def after_sign_in_path_for(resource_or_scope)
    if current_user.present? and current_user.admin?
      root_path  
    else
      root_path
    end
  end

  def authenticate_user
    unless user_signed_in?
      redirect_to root_path
    end  
  end  






  def open_spreadsheet(file_name, file_path)
    case File.extname(file_name)
      when '.csv' then
        Roo::CSV.new(file_path, {file_warning: :ignore})
      when '.xls' then
        Roo::Excel.new(file_path, {file_warning: :ignore})
      when '.xlsx' then
        Roo::Excelx.new(file_path, {file_warning: :ignore})
      else
        "Unknown file type: #{file_name}"
    end
  end

  protected

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password) }
  # end
end
