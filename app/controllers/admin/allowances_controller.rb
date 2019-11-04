class Admin::AllowancesController < ApplicationController
  layout "admin/application"

  def index
  	get_form_data
  	month_list = []
  	7.times do |i|
  		d = Date.today - i.month
  		month_list << d.strftime("%b-%Y")
  	end	
	  @allowance_month_list = month_list.reverse
    @allowance_ti_beat_list = User.where(id: StationUnderTiUser.all.pluck(:user_id).uniq).pluck(:first_name, :id)
    @allowance_station_list = Station.where(id: StationUnderTiUser.all.pluck(:station_id).uniq).pluck(:code, :id)
    if params[:is_data_filter].present?
      category_ids = params[:selected_category_ids].split(',').map{|x|x.to_i}.delete_if {|x| x ==0}
      @allowance_type = params[:selected_allowance_type].split(',').map{|x|x}.delete_if {|x| x == "multiselect-all"} if params[:selected_allowance_type].present?
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

      @allowance_reports_data = AllowanceSummary.where(station_id: select_station_ids, employee_category_id: category_ids, month: select_allowance_months)
    end

  end

  def new
  	get_form_data

	  month_list = []
  	7.times do |i|
  		d = Date.today - i.month
  		month_list << d.strftime("%b-%Y")
  	end	
	  @allowance_month_list = month_list.reverse
	  if params["selected_category"].present?	
	    @@allowance_old_params_data = params 
    	selected_category = params["selected_category"].split(',').map!{|e| e.to_i}.delete_if {|x| x ==0}
	  	station = params["station"].to_i
	  	selected_month = params["selected_month"]
      allowance_data = {}
	  	selected_category.map{|no|allowance_data[no] = {}}
	  	data = AllowanceSummary.where(month: selected_month, employee_category_id: selected_category, station_id: station) 
	  	data.map{ |e| allowance_data[e.employee_category_id] = e }
	  	
	  	@allowance_selected_data = allowance_data
	  	
	  end	
	  

  end

  def create
    @allowance_data_status = AllowanceSummary.create_or_update_allowance(params)
    temp_data = @@allowance_old_params_data
    selected_category = temp_data["selected_category"].split(',').map!{|e| e.to_i}.delete_if {|x| x ==0}
    station = temp_data["station"].to_i
    selected_month = temp_data["selected_month"]
    allowance_data = {}
    selected_category.map{|no|allowance_data[no] = {}}
    data = AllowanceSummary.where(month: selected_month, employee_category_id: selected_category, station_id: station) 
    data.map{ |e| allowance_data[e.employee_category_id] = e }
    @allowance_selected_data = allowance_data
  end

  def delete_allowance
    delete_allowance_id = params[:delete_allowance_id]
    id = delete_allowance_id.to_i
    AllowanceSummary.destroy(id)
    
      respond_to do |format|
        format.js
      end
  end

  def get_form_data
  	@allowance_category_list = EmployeeCategory.all.map{ |emp| [[emp.group,emp.name].join("-"),emp.id]}
	  stn = StationUnderTiUser.where(user_id: current_user.id).pluck(:station_id)
	  @allowance_station_list = stn.map{|s| Station.where(id: s).pluck(:code,:id).flatten} rescue nil
	  
  end

end
