class Admin::EmployeesController < ApplicationController
	layout "admin/application"

	def index
		@employees = Employee.all
    @employees = @employees.paginate(:page => params[:page] || 1, :per_page => 20)
	end

	def new
		get_form_data
	end

	def create
		Employee.create_or_update_employee(params)
	end

	def edit
		get_form_data
		emp_id = params[:id].to_i
		@edit_employee_basic_data = Employee.find(emp_id)
		@edit_employee_category_data = EmployeeCategoryDetail.where(id: emp_id)
	end

	def get_form_data
		@employee_station_list = Station.where(division_id: current_user.division_id).map{|stn| ["#{stn.code}-#{stn.name}",stn.id]}
		@employee_post_list = EmployeePost.all.map{|emp| ["Group-#{emp.group}-#{emp.post}-Level-#{emp.level_p7}-GradePay-#{emp.grade_pay_p6}",emp.id]}		
		
	end

	def destroy

		respond_to do |format|
      format.js
    end
	end


end
