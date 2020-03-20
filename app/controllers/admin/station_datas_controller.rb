class Admin::StationDatasController < ApplicationController
	layout "admin/application"

  def index

  	if User.find(current_user.id).user_role.is_superadmin
  		stn_list = Station.where(division_id: current_user.division_id).map{|stn| ["#{stn.code}-#{stn.name}",stn.id]}
  	elsif User.find(current_user.id).user_under == "TI"
  		stn_list = StationUnderTiUser.where(user_id: current_user.id).joins(:station).pluck(:code,:station_id)
  	else
  		stn_list = StationUnderTiUser.where(user_id: current_user.id).joins(:station).pluck(:code,:station_id)
  	end
		@station_data_station_list = stn_list
  	
  	
  end

  def new
  end
end
