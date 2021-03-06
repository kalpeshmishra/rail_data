class Admin::EmployeesController < ApplicationController
	layout "admin/application"


	def index
		get_form_data
		if params[:is_data_filter].present?
			@employees = Employee.where(station_id: params[:selected_station].to_i).order(employee_post_id: :asc)
			@employees = @employees.paginate(:page => params[:page] || 1, :per_page => 20)
		end
    

	end

	def new
		get_form_data
	end

	def create
		get_form_data
		if params[:is_add_employee_category].present? and params[:is_add_employee_category] == "true"
			EmployeeCategoryDetail.create_employee_category(params)
			@employee_category_details_data = EmployeeCategoryDetail.where(employee_id: params[:category_employee_id].to_i).order(date_in_level: :asc)
		elsif params[:is_add_employee_transfer].present?
			EmployeeTransferDetail.create_employee_transfer(params)
			@employee_transfer_details_data = EmployeeTransferDetail.where(employee_id:  params[:transfer_employee_id].to_i).order(resume_date: :asc)
		elsif params[:is_add_employee_training].present?
			EmployeeTrainingDetail.create_employee_training(params)
			@employee_training_details_data = EmployeeTrainingDetail.where(employee_id:  params[:training_employee_id].to_i).order(end_date: :asc)
		elsif params[:is_add_employee_medical].present?
			EmployeeMedicalDetail.create_employee_medical(params)
			@employee_medical_details_data = EmployeeMedicalDetail.where(employee_id:  params[:medical_employee_id].to_i).order(fit_date: :asc)
		elsif params[:is_add_employee_dar].present?
			EmployeeDarDetail.create_employee_dar(params)
			@employee_dar_details_data = EmployeeDarDetail.where(employee_id:  params[:dar_employee_id].to_i).order(issue_date: :asc)
		elsif params[:is_add_employee_award].present?
			EmployeeAwardDetail.create_employee_award(params)
			@employee_award_details_data = EmployeeAwardDetail.where(employee_id:  params[:award_employee_id].to_i).order(award_date: :asc)
		elsif params[:is_add_employee_family].present?
			EmployeeFamilyDetail.create_employee_family(params)
			@employee_family_details_data = EmployeeFamilyDetail.where(employee_id:  params[:family_employee_id].to_i)
		else
			@employee_save_status = Employee.create_or_update_employee(params)
		end
		
			respond_to do |format|
				format.html
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
		@employee_medical_details_data = EmployeeMedicalDetail.where(employee_id:  emp_id).order(fit_date: :asc)
		@employee_dar_details_data = EmployeeDarDetail.where(employee_id:  emp_id).order(issue_date: :asc)
		@employee_award_details_data = EmployeeAwardDetail.where(employee_id:  emp_id).order(award_date: :asc)
		@employee_family_details_data = EmployeeFamilyDetail.where(employee_id:  emp_id)
		
		# respond_to do |format|
	 #    format.js
	 #  end	
	end

	def get_form_data
		if User.find(current_user.id).user_role.is_superadmin
  		stn_list = Station.where(division_id: current_user.division_id).map{|stn| ["#{stn.code}-#{stn.name}",stn.id]}
  	elsif User.find(current_user.id).user_under == "TI"
  		stn_list = StationUnderTiUser.where(user_id: current_user.id).joins(:station).pluck(:code,:station_id)
  	else
  		stn_list = StationUnderTiUser.where(user_id: current_user.id).joins(:station).pluck(:code,:station_id)
  	end
		@employee_station_list = stn_list
		@employee_post_list = EmployeePost.all.map{|emp| ["Group-#{emp.group}-#{emp.post}-Level-#{emp.level_p7}-GradePay-#{emp.grade_pay_p6}",emp.id]}		
		@employee_category_list = EmployeeCategory.all.map{|category| ["Group-#{category.group}-#{category.name}",category.id]}		
		
	end

	def destroy

		respond_to do |format|
      format.js
    end
	end

	def delete_employee
    emp_id = params[:employee_id].to_i
    Employee.destroy(emp_id)
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

  def delete_employee_medical_detail
  	delete_medical_detail_id = params[:delete_medical_detail_id].to_i
    EmployeeMedicalDetail.destroy(delete_medical_detail_id)
    respond_to do |format|
      format.js
    end

  end

  def delete_employee_dar_detail
  	delete_dar_detail_id = params[:delete_dar_detail_id].to_i
    EmployeeDarDetail.destroy(delete_dar_detail_id)
    respond_to do |format|
      format.js
    end

  end

  def delete_employee_award_detail
  	delete_award_detail_id = params[:delete_award_detail_id].to_i
    EmployeeAwardDetail.destroy(delete_award_detail_id)
    respond_to do |format|
      format.js
    end

  end

  def find_employee_number
  	emp_no = params[:emp_number]
  	@is_emp_number_exist = Employee.find_by_emp_number(emp_no).present?
  end


end
