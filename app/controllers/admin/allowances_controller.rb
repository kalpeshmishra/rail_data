class Admin::AllowancesController < ApplicationController
  layout "admin/application"

  def index
  	get_form_data
  	month_list = []
  	7.times do |i|
  		d = Date.today - i.month
  		month_list << d.strftime("%b-%y")
  	end	
	  @allowance_month_list = month_list.reverse
  end

  def new
  	get_form_data

	  month_list = []
  	7.times do |i|
  		d = Date.today - i.month
  		month_list << d.strftime("%b-%y")
  	end	
	  @allowance_month_list = month_list.reverse
	  
		if params["selected_category"].present?	
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

  end

  def get_form_data
  	@allowance_category_list = EmployeeCategory.all.map{ |emp| [[emp.group,emp.name].join("-"),emp.id]}
	  stn = StationUnderTiUser.where(user_id: current_user.id).pluck(:station_id)
	  @allowance_station_list = stn.map{|s| Station.where(id: s).pluck(:code,:id).flatten} rescue nil
	  
  end

end
