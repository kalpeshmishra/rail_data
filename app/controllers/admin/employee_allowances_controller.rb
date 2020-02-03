class Admin::EmployeeAllowancesController < ApplicationController
  layout "admin/application"


  def index
  end

  def new
  	get_form_data
  	if params[:is_station_filter].present?
  		stn_id = params[:selected_station_id].to_i
  		@employee_list = Employee.where(station_id: stn_id).map{ |emp| [[emp.emp_number,emp.first_name,emp.last_name].join("-"),emp.id]}
  	end

  	if params[:is_data_filter].present?
  		selected_employee_id = params[:selected_employee].split(',').map!{|e| e.to_i}.delete_if {|x| x ==0}
  		station = params["station"].to_i
	  	selected_month = params["selected_month"]
	  	employee_allowance_data = {}
	  	selected_employee_id.map{|no|
	  		emp = Employee.where(id: no).pluck(:id,:first_name,:last_name,:emp_number)
	  		employee_allowance_data[emp] = {}
	  	}
	  	data = EmployeeAllowance.where(month: selected_month, employee_id: selected_employee_id, station_id: station) 
	  	data.map{ |e| employee_allowance_data[e.employee_id] = e }
  		
  		@employee_allowance_selected_data = employee_allowance_data
  	end

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
