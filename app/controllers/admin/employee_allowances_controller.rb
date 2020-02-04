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
  		@@employee_allowance_old_params_data = params 
  		
  		@employee_allowance_selected_data = get_emp_allowance_data(params)
  	
  	end

  end

  def create
  	get_form_data
  	@employee_allowance_data_status = EmployeeAllowance.create_or_update_emp_allowance(params)
  	temp_data = @@employee_allowance_old_params_data
		
		@employee_allowance_selected_data = get_emp_allowance_data(temp_data)

  end


  def get_form_data
  	stn_list = StationUnderTiUser.where(user_id: current_user.id).joins(:station).pluck(:code,:station_id)
	  @employee_allowance_station_list = stn_list.uniq.sort
	  
	  month_list = []
	  date_range = (Date.parse('2020-01-01')..Date.today).uniq
    date_range.map{ |x| month_list << x.strftime("%b-%Y") if month_list.exclude?(x.strftime("%b-%Y"))}
    @employee_allowance_month_list = month_list



  end

  def get_emp_allowance_data(temp_data)
  	selected_employee_id = temp_data[:selected_employee].split(',').map!{|e| e.to_i}.delete_if {|x| x ==0}
		station = temp_data["station"].to_i
  	selected_month = temp_data["selected_month"]
  	employee_allowance_data = {}
  	selected_employee_id.map{|no|
  		emp = Employee.where(id: no).joins(:employee_post).pluck(:id,:first_name,:last_name,:emp_number,:employee_post_id,:post_code)
  		employee_allowance_data[no] = emp
  	}
  	data = EmployeeAllowance.where(month: selected_month, employee_id: selected_employee_id, station_id: station) 
  	data.map{ |e| employee_allowance_data[e.employee_id]<< e }

  	return employee_allowance_data
  end


  def delete_employee_allowance
    id = params[:delete_employee_allowance_id].to_i

    EmployeeAllowance.destroy(id)
    
      respond_to do |format|
        format.js
      end
  end



end
