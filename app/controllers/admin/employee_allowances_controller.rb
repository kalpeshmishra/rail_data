class Admin::EmployeeAllowancesController < ApplicationController
  layout "admin/application"


  def index
  end

  def new
  	get_form_data
  end

  def create
  end


  def get_form_data
  	stn = StationUnderTiUser.where(user_id: current_user.id).pluck(:station_id)
	  @employee_allowance_station_list = stn.map{|s| Station.where(id: s).pluck(:code,:id).flatten} rescue nil
	  
	  month_list = []
	  date_range = (Date.parse('2020-01-01')..Date.today).uniq
    date_range.map{ |x| month_list << x.strftime("%b-%Y") if month_list.exclude?(x.strftime("%b-%Y"))}
    @employee_allowance_month_list = month_list



  end



end
