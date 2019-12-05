class Admin::EmployeeCadresController < ApplicationController
  layout "admin/application"	

  def index
    employee_cader_form_data
  	
    if params[:is_data_with_total_filter].present?
      station_ids = params[:selected_stations].split(',').map{|x|x.to_i}.delete_if {|x| x ==0}
      emp_post_ids = params[:selected_post].split(',').map{|x|x.to_i}.delete_if {|x| x ==0}

      sanction_cadre_data = EmployeeCadre.where(station_id: station_ids, employee_post_id: emp_post_ids)
      man_on_roll_data = Employee.where(station_id: station_ids, employee_post_id: emp_post_ids)
      cadre_hash_data = EmployeeCadre.get_cadre_with_total(sanction_cadre_data,man_on_roll_data)
      



      @employee_cadre_report_data = cadre_hash_data
    end  

  end

  def new
  	employee_cader_form_data

  end

  def create
  	EmployeeCadre.create_or_update_employee_cadre(params)
  	employee_cader_form_data
  end

  def employee_cader_form_data
  	 # @employee_cadre_station_list = Station.where(id: StationUnderTiUser.all.pluck(:station_id).uniq).pluck(:code, :id)
  	@employee_cadre_station_list = Station.where(division_id: current_user.division_id).map{|stn| ["#{stn.code}-#{stn.name}",stn.id]}
  	@employee_cader_post_list = EmployeePost.all.map{|emp| ["#{emp.post}-Level-#{emp.level_p7}-GradePay-#{emp.grade_pay_p6}-Group-#{emp.group}",emp.id]}
    @employee_cadre = EmployeeCadre.where(station_id: params[:selected_station].to_i)
  end


end
