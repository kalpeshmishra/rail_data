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


    if params[:is_data_station_filter].present?
      station_ids = params[:selected_stations].split(',').map{|x|x.to_i}.delete_if {|x| x ==0}
      emp_post_ids = params[:selected_post].split(',').map{|x|x.to_i}.delete_if {|x| x ==0}

      sanction_cadre_data = EmployeeCadre.where(station_id: station_ids, employee_post_id: emp_post_ids)
      man_on_roll_data = Employee.where(station_id: station_ids, employee_post_id: emp_post_ids)
      
      cadre_data_hash = EmployeeCadre.get_cadre_station_data(sanction_cadre_data,man_on_roll_data)
      @cadre_station_header = cadre_data_hash[:header_hash]
      @cadre_station_data = cadre_data_hash[:data_hash]





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
  	temp_cadre_stn = Station.where(division_id: current_user.division_id)
    @employee_cadre_station_list = temp_cadre_stn.map{|stn| ["#{stn.code}-#{stn.name}",stn.id]}
    @employee_cadre_station_hash = {}
    temp_cadre_stn.map{|station| @employee_cadre_station_hash[station.id] = [station.code,station.name]}
  	@employee_cader_post_list = EmployeePost.all.map{|emp| ["#{emp.post}-Level-#{emp.level_p7}-GradePay-#{emp.grade_pay_p6}-Group-#{emp.group}",emp.id]}
    @employee_cadre = EmployeeCadre.where(station_id: params[:selected_station].to_i)
  end

  def delete_employee_cadre
    delete_cadre_id = params[:delete_employee_cadre_id].to_i
    EmployeeCadre.destroy(delete_cadre_id)
    respond_to do |format|
      format.js
    end
    
  end


end
