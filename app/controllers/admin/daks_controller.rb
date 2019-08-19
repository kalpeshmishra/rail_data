class Admin::DaksController < ApplicationController
	layout "admin/application"
	
	def index
		
	end

	def new
		user_list = User.find(UserRole.where(is_dak_access: true).pluck(:user_id))

		dak_user_list = {}
		dak_user_list.merge!("AdiDivision" => {})
		user_list.each do |user|
			if user.id != current_user.id
				dak_user_list["AdiDivision"].merge!("#{user.user_under}" => {}) if dak_user_list["AdiDivision"].keys.exclude?(user.user_under)
				dak_user_list["AdiDivision"][user.user_under].merge!("#{user.first_name}" => user.id)	
			end
		end
		@dak_recipient_list = dak_user_list

	end

	def create
		temp_list = params.values.select {|item| item.include?("select_recipient")}
		select_user_id = []
		temp_list.each do |v|
			v = v.split("_")
			select_user_id << v[2].to_i
		end	
		
		
	end

	def show
		
	end

	def edit
		
	end

	def update
		
	end

end
