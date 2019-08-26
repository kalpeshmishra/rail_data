class Admin::DaksController < ApplicationController
	layout "admin/application"
	require 'will_paginate/array'
	
	def index
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
		
		@all_dak_received = @all_dak_received.sort{|a| a.created_at}
		@all_dak_received = @all_dak_received.paginate(:page => (params[:page] || 1), :per_page => 10)
		@unread_dak_received = @unread_dak_received.sort{|a| a.created_at}
		@unread_dak_received = @unread_dak_received.paginate(:page => (params[:page] || 1), :per_page => 10)
		@read_dak_received = @read_dak_received.sort{|a| a.created_at}
		@read_dak_received = @read_dak_received.paginate(:page => (params[:page] || 1), :per_page => 10)		

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
			
		
		
	end

	def show
		
	end

	def edit
		
	end

	def update
		
	end
	

end
