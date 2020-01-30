class Employee < ApplicationRecord
	belongs_to :station
	belongs_to :employee_post
	has_many	 :employee_category_details
	has_many	 :employee_transfer_details
	has_many	 :employee_training_details
	has_many	 :employee_medical_details
	has_many	 :employee_dar_details
	has_many	 :employee_award_details


	after_destroy :remove_all_details_realted_to_employee

	def remove_all_details_realted_to_employee
		emp_id = self.id
		if self.employee_category_details.present?
			category_details = EmployeeCategoryDetail.where(employee_id: emp_id)
      category_details.destroy_all
		end
		if self.employee_transfer_details.present?
			transfer_details = EmployeeTransferDetail.where(employee_id: emp_id)
      transfer_details.destroy_all
		end
		if self.employee_training_details.present?
			training_details = EmployeeTrainingDetail.where(employee_id: emp_id)
      training_details.destroy_all
		end
		if self.employee_medical_details.present?
			medical_details = EmployeeMedicalDetail.where(employee_id: emp_id)
      medical_details.destroy_all
		end
		if self.employee_dar_details.present?
			dar_details = EmployeeDarDetail.where(employee_id: emp_id)
      dar_details.destroy_all
		end
		if self.employee_award_details.present?
			award_details = EmployeeAwardDetail.where(employee_id: emp_id)
      award_details.destroy_all
		end

	end

	def self.create_or_update_employee(params)
		
		record_id = params["record_id"].to_i if params["record_id"].present?
		employee = self.find(record_id) rescue nil if record_id.present?
    employee = self.new if employee.blank?

    employee.first_name = params["first_name"] rescue nil
		employee.last_name = params["last_name"] rescue nil
		employee.father_name = params["father_name"] rescue nil
		employee.mother_name = params["mother_name"] rescue nil
		employee.spouse_name = params["spouse_name"] rescue nil
		employee.emp_number = params["pf_nps_number"] rescue nil
		employee.pran_number = params["pran_number"] rescue nil
		employee.pan_number = params["pan_number"] rescue nil
		employee.aadhaar = params["aadhaar_number"] rescue nil
		employee.gender = params["gender"] rescue nil
		employee.religion = params["religion"] rescue nil
		employee.community = params["community"] rescue nil
		employee.birth_date = params["birth_date"] rescue nil
		employee.marital_status = params["marital_status"] rescue nil
		employee.disability = params["disability"] rescue nil
		employee.appointment_date = params["appointment_date"] rescue nil
		employee.temporary_address = params["current_address"] rescue nil
		employee.permanent_address = params["permanent_address"] rescue nil
		employee.mobile_no = params["mobile_no"] rescue nil
		employee.alternate_number = params["alternate_number"] rescue nil
		employee.email_id = params["email_id"] rescue nil
		employee.appointment_mode = params["appointment_mode"] rescue nil
		employee.employee_post_id = params["employee_post"].to_i rescue nil 
		employee.station_id = params["current_station"].to_i rescue nil
    employee.save	
	end

end
