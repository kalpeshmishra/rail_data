class EmployeeFamilyDetail < ApplicationRecord
	belongs_to :employee

	def self.create_employee_family(params)
		EmployeeFamilyDetail.create(employee_id: params[:family_employee_id], name: params[:member_name], relation: params[:family_relation],gender: params[:family_gender],marital_status: params[:family_marital_status],dependancy: params[:family_dependancy],physicaly_challanged: params[:family_physicaly_challanged],blood_group: params[:family_blood_group],aadhaar: params[:family_aadhaar], mobile: params[:family_mobile],birth_date: params[:family_birth_date], remarks: params[:family_remark])
	end

end
