class Admin::EmployeeAllowancesController < ApplicationController
  layout "admin/application"


  def index
  	get_form_data
  	month_list = []
	  date_range = (Date.parse('2020-01-01')..Date.today).uniq
    date_range.map{ |x| month_list << x.strftime("%b-%Y") if month_list.exclude?(x.strftime("%b-%Y"))}

	  @employee_allowance_month_list = month_list
    @employee_allowance_ti_beat_list = User.where(id: StationUnderTiUser.all.pluck(:user_id).uniq.reject{|x| x==1}).pluck(:first_name, :id)
    @employee_allowance_station_list = Station.where(id: StationUnderTiUser.all.pluck(:station_id).uniq).pluck(:code, :id)
    @employee_allowance_category_list = EmployeeCategory.all.map{ |emp| [[emp.group,emp.name].join("-"),emp.id]}

    if params[:is_data_filter].present?
    	category_ids = params[:selected_category_ids].split(',').map{|x|x.to_i}.delete_if {|x| x ==0}
    	post_ids = EmployeePost.where(employee_category_id: category_ids).pluck(:id)

      @employee_allowance_type = params[:selected_employee_allowance_type].split(',').map{|x|x}.delete_if {|x| x == "multiselect-all"} if params[:selected_employee_allowance_type].present?
      report_type = params[:report_type]
      report_period = params[:report_period]

      if params[:selected_ti_beat_ids].present?
      	ti_beat_ids = params[:selected_ti_beat_ids].split(',').map{|x|x.to_i}.delete_if {|x| x ==0}
        select_station_ids = StationUnderTiUser.where(user_id: ti_beat_ids).pluck(:station_id)
      elsif params[:selected_station_ids].present?
        select_station_ids = params[:selected_station_ids].split(",").map{|x| x.to_i}
      end

      if params[:selected_years].present?
        selected_years = params[:selected_years].split(',').map{|x|x}.delete_if {|x| x == "multiselect-all"}

        select_allowance_months = []
        temp_month = [['Apr', 'May', 'June', 'July', 'Aug', 'Sept', 'Oct', 'Nov', 'Dec'],['Jan', 'Feb', 'Mar']]

        selected_years.each do |years|
          temp_year = years.split("-")
          2.times do |i| 
            data = temp_month[i].map { |month| "#{month}-#{temp_year[i]}" }
            select_allowance_months << data
          end 
        end
        select_allowance_months = select_allowance_months.flatten
      elsif params[:selected_months].present?
        select_allowance_months = params[:selected_months].split(",").map{|x|x}.delete_if {|x| x == "multiselect-all"}
      end  
      temp_data= EmployeeAllowance.where(station_id: select_station_ids, employee_post_id: post_ids, month: select_allowance_months)

      final_data = {}
      temp_data.each do |data|
      	final_data[data.station] = {} if final_data[data.station].blank?
      	final_data[data.station][data.month] = {} if final_data[data.station][data.month].blank?
      	
      	if final_data[data.station][data.month][data.employee_post.employee_category].blank?
      	  final_data[data.station][data.month][data.employee_post.employee_category] = {"over_time_hours" => data.over_time_hours.to_i ,"over_time_minutes" => data.over_time_minutes.to_i, "over_time_amount" => data.over_time_amount.to_i,"transpotation_days" => data.transpotation_days.to_i,"transpotation_amount" => data.transpotation_amount.to_i,"contingency_amount" => data.contingency_amount.to_i}
      	else
      		final_data[data.station][data.month][data.employee_post.employee_category]["over_time_hours"]+= data.over_time_hours.to_i
      		final_data[data.station][data.month][data.employee_post.employee_category]["over_time_minutes"]+= data.over_time_minutes.to_i
      		final_data[data.station][data.month][data.employee_post.employee_category]["over_time_amount"]+= data.over_time_amount.to_i
      		final_data[data.station][data.month][data.employee_post.employee_category]["transpotation_days"]+= data.transpotation_days.to_i
      		final_data[data.station][data.month][data.employee_post.employee_category]["transpotation_amount"]+= data.transpotation_amount.to_i
      		final_data[data.station][data.month][data.employee_post.employee_category]["contingency_amount"]+= data.contingency_amount.to_i

      	end

      end	
      @employee_allowance_reports_data = final_data

    end


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
  	if User.find(current_user.id).user_role.is_superadmin
  		stn_list = Station.where(division_id: current_user.division_id).map{|stn| ["#{stn.code}-#{stn.name}",stn.id]}
  	else
  		stn_list = StationUnderTiUser.where(user_id: current_user.id).joins(:station).pluck(:code,:station_id)
  	end
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
