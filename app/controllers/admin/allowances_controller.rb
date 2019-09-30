class Admin::AllowancesController < ApplicationController
  layout "admin/application"
  def index
  end

  def new
  	@allowance_category_list = EmployeeCategory.all.map{ |emp| [[emp.group,emp.name].join("-"),emp.id]}
	  stn = StationUnderTiUser.where(user_id: current_user.id).pluck(:station_id)
	  @allowance_station_list = stn.map{|s| Station.where(id: s).pluck(:code,:id).flatten} rescue nil
	  
	  month_list = []
  	3.times do |i|
  		d = Date.today - i.month
  		month_list << d.strftime("%b-%y")
  	end	
	  @allowance_month_list = month_list.reverse
	  
		if params["selected_category"].present?	
	  	selected_category = params["selected_category"].split(',').map!{|e| e.to_i}.delete_if {|x| x ==0}
	  	station = params["station"].to_i
	  	selected_month = params["selected_month"]

	  	@allowance_selected_category_data = AllowanceSummary.where(month: selected_month, employee_category_id: selected_category, station_id: station) 
	  	@allowance_selected_category = selected_category
	  	binding.pry

	  	list = {}
	  	

	  	EmployeeCategory.find(selected_category).map{ |emp| 
	  		if list[emp.group].blank? 
	  			list[emp.group] = {emp.name => [emp.id,emp.employee_posts.pluck(:post_code).join(' / ')]}
	  		else
	  			list[emp.group].merge!(emp.name => [emp.id,emp.employee_posts.pluck(:post_code).join(' / ')])
	  		end
	  	}
	  	@allowance_selected_category_list = list
	  end	
	  

  end

  def create
  	AllowanceSummary.create_or_update_allowance(params)
  end
end
