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
		get_form_data
		if params[:is_add_employee_category].present? and params[:is_add_employee_category] == "true"
			EmployeeCategoryDetail.create_employee_category(params)
			@employee_category_details_data = EmployeeCategoryDetail.where(employee_id: params[:employee_id].to_i).order(date_in_level: :asc)
		elsif params[:is_add_employee_transfer].present?
			EmployeeTransferDetail.create_employee_transfer(params)
			@employee_transfer_details_data = EmployeeTransferDetail.where(employee_id:  params[:employee_id].to_i).order(resume_date: :asc)
		elsif params[:is_add_employee_training].present?
			EmployeeTrainingDetail.create_employee_training(params)
			@employee_training_details_data = EmployeeTrainingDetail.where(employee_id:  params[:employee_id].to_i).order(end_date: :asc)
		else
			Employee.create_or_update_employee(params)
		end
			
		respond_to do |format|
      format.js
    end

	end

	def edit
		get_form_data
		emp_id = params[:id].to_i
		@edit_employee_basic_data = Employee.find(emp_id)
		@employee_category_details_data = EmployeeCategoryDetail.where(employee_id: emp_id).order(date_in_level: :asc)
		@employee_transfer_details_data = EmployeeTransferDetail.where(employee_id: emp_id).order(relieve_date: :asc)
		@employee_training_details_data = EmployeeTrainingDetail.where(employee_id: emp_id).order(end_date: :asc)

	end

	def get_form_data
		@employee_station_list = Station.where(division_id: current_user.division_id).map{|stn| ["#{stn.code}-#{stn.name}",stn.id]}
		@employee_post_list = EmployeePost.all.map{|emp| ["Group-#{emp.group}-#{emp.post}-Level-#{emp.level_p7}-GradePay-#{emp.grade_pay_p6}",emp.id]}		
		@employee_category_list = EmployeeCategory.all.map{|category| ["Group-#{category.group}-#{category.name}",category.id]}		
		
	end

	def destroy

		respond_to do |format|
      format.js
    end
	end

	def delete_employee_category_detail
    delete_category_detail_id = params[:delete_category_detail_id].to_i
    EmployeeCategoryDetail.destroy(delete_category_detail_id)
    respond_to do |format|
      format.js
    end

  end

  def delete_employee_transfer_detail
    delete_transfer_detail_id = params[:delete_transfer_detail_id].to_i
    EmployeeTransferDetail.destroy(delete_transfer_detail_id)
    respond_to do |format|
      format.js
    end

  end

  def delete_employee_training_detail
  	delete_training_detail_id = params[:delete_training_detail_id].to_i
    EmployeeTrainingDetail.destroy(delete_training_detail_id)
    respond_to do |format|
      format.js
    end

  end



end
