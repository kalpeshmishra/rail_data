class Admin::AllowancesController < ApplicationController
  layout "admin/application"
  def index
  end

  def new
  	@allowance_category_list = [["CTNL/ATNL","Contorller"],["SS/SM","StationMaster"],["CTNC/SrTNC/TNC","TrainClerk"],["ShtgMaster","ShtgMaster"],["PointsMan(C)","PointsMan(C)"],["Cook(C)","Cook(C)"]]
  	@allowance_station_list = [["ADI","ADI"],["KKF","KKF"]]
  end

  def create
  end
end
