class EmployeeFamilyDetail < ApplicationRecord
	belongs_to :employee

	def self.create_employee_family(params)
		EmployeeFamilyDetail.create(employee_id: params[:family_employee_id], name: params[:member_name], relation: params[:relation], remarks: params[:family_remark])
	end

end
