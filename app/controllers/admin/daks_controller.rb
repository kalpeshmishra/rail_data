class Admin::DaksController < ApplicationController
	layout "admin/application"
	require 'will_paginate/array'
	
	def index
		
		if params[:dak_type] == "received"
			all_dak_received_data = DakReceiver.where(reciever_user_id: current_user.id)
			all_dak_received_id = []
			read_dak_received_id = []
			unread_dak_received_id =[]
			all_dak_received_data.each do |i|
				all_dak_received_id << i.dak_id 
				if i.is_read == true
					read_dak_received_id << i.dak_id
				else
					unread_dak_received_id << i.dak_id
				end
			end
			@unread_dak_received = Dak.find(unread_dak_received_id)
			@read_dak_received = Dak.find(read_dak_received_id)
			@all_dak_received = (@read_dak_received + @unread_dak_received).reject(&:blank?)
			
			@all_dak_received = @all_dak_received.sort_by{|a| a.created_at}.reverse
			@all_dak_received = @all_dak_received.paginate(:page => (params[:all] || 1), :per_page => 15)
			@read_dak_received = @read_dak_received.sort_by{|a| a.created_at}.reverse
			@read_dak_received = @read_dak_received.paginate(:page => (params[:read] || 1), :per_page => 15)		
			@unread_dak_received = @unread_dak_received.sort_by{|a| a.created_at}.reverse
			@unread_dak_received = @unread_dak_received.paginate(:page => (params[:unread] || 1), :per_page => 15)
			
			if params[:active_tab].present? 
				if params[:active_tab] == "unread"
					@unread_tab_select = "active"
					@read_tab_select = ""
					@all_tab_select = ""
				elsif params[:active_tab] == "read"
					@unread_tab_select = ""
					@read_tab_select = "active"
					@all_tab_select = ""
				elsif params[:active_tab] == "all"
					@unread_tab_select = ""
					@read_tab_select = ""
					@all_tab_select = "active"
				end			
			else
				@unread_tab_select = "active"
				@read_tab_select = ""
				@all_tab_select = ""
			end

		elsif params[:dak_type] == "dispatch"
			
			all_dak_dispatch_data = Dak.where(creater_user_id: current_user.id)
			@all_dak_dispatch = all_dak_dispatch_data.sort_by{|a| a.created_at}.reverse
			@all_dak_dispatch = @all_dak_dispatch.paginate(:page => (params[:all] || 1), :per_page => 15)
			@unread_dak_dispatch = []
			all_dak_dispatch_data.each do |data|
				if DakReceiver.where(dak_id: data.id).pluck(:is_read).include? false
				  @unread_dak_dispatch << data
				end
			end
			@unread_dak_dispatch = @unread_dak_dispatch.paginate(:page => (params[:all] || 1), :per_page => 15)
		end

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
		user_id = current_user.id
		Dak.create_dak_data(params,user_id)
		# binding.pry
		# render "admin/daks/new"

		# redirect_to new_admin_dak_path, :notice => 'Message sended successfully .' 
		

	end

	def show
		
	end

	def edit
		
	end

	def update
		update_dak_id = params[:id].to_i
		DakReceiver.where(dak_id: update_dak_id, reciever_user_id: current_user.id).update(is_read: true, dak_read_time_date: Time.now)
		respond_to do |format|
      format.js
    end
	end
	

end
