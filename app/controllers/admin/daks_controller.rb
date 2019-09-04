class Admin::DaksController < ApplicationController
	layout "admin/application"
	require 'will_paginate/array'
	
	def index
		form_fields_data
		delete_dak_without_receiver_or_attachment
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
		end	
		
		if params[:dak_type] == "dispatch"
			all_dak_dispatch_data = Dak.where(creater_user_id: current_user.id)
			@all_dak_dispatch = all_dak_dispatch_data.sort_by{|a| a.created_at}.reverse
			@all_dak_dispatch = @all_dak_dispatch.paginate(:page => (params[:all] || 1), :per_page => 15)
			@unread_dak_dispatch = []
			all_dak_dispatch_data.each do |data|
				if DakReceiver.where(dak_id: data.id).pluck(:is_read).include? false
				  @unread_dak_dispatch << data
				end
			end
			@unread_dak_dispatch = @unread_dak_dispatch.sort_by{|a| a.created_at}.reverse
			@unread_dak_dispatch = @unread_dak_dispatch.paginate(:page => (params[:all] || 1), :per_page => 15)
		end

		if params[:search_data].present?
			receiver_user_id = params[:receiver_list]
			from_dispatch_date = params[:from_dispatch_date]
			to_dispatch_date = params[:to_dispatch_date]
			
			letter_type = params[:letter_type]
			from_letter_date = params[:from_letter_date]
			to_letter_date = params[:to_letter_date]
			letter_number = params[:letter_number]

			search_data = Dak.where("created_at >= ? and created_at <= ? and creater_user_id = ?", from_dispatch_date.to_date , to_dispatch_date.to_date, current_user.id).includes(:dak_receivers) if params[:from_dispatch_date].present? and params[:to_dispatch_date].present?
			search_data = search_data.where("letter_type = ? ", letter_type) if params[:letter_type].present?
			search_data = search_data.where("letter_number LIKE ?","%#{letter_number}%") if params[:letter_number].present?
			@search_dispatch_data = search_data.select { |data|
				  if data.dak_receivers.pluck(:reciever_user_id)[0] == receiver_user_id.to_i
						data
					end	
				}
			@search_dispatch_data = @search_dispatch_data.paginate(:page => (params[:all] || 1), :per_page => 15)
		end	
	end

	def new
		form_fields_data  

	end

	def create
		form_fields_data
		user_id = current_user.id
		@dak_save_status = Dak.create_dak_data(params,user_id)
	end

	def form_fields_data
		@letter_type_list = [['General', 'General'], ['Safety', 'Safety'], ['SafetyBulletin', 'SafetyBulletin'], ['MonthlySafteyRule', 'MonthlySafteyRule'], ['GeneralCircular', 'GeneralCircular'], ['ManPowerPlanning', 'ManPowerPlanning'], ['DivisionOfficeOrder', 'DivisionOfficeOrder'], ['ControlOfficeOrder', 'ControlOfficeOrder']]
		user_list = User.find(UserRole.where(is_dak_access: true).pluck(:user_id))

		dak_user_list = {}
		dak_user_list.merge!("AdiDivision" => {})
		dak_search_user = []
		user_list.each do |user|
			if user.id != current_user.id
				dak_user_list["AdiDivision"].merge!("#{user.user_under}" => {}) if dak_user_list["AdiDivision"].keys.exclude?(user.user_under)
				dak_user_list["AdiDivision"][user.user_under].merge!("#{user.first_name}" => user.id)	
				dak_search_user << [user.first_name,user.id]
			end
		end
		
		@dak_recipient_list = dak_user_list
		@dak_search_recipient_list = dak_search_user
	end
	def delete_dak_without_receiver_or_attachment
		dak_data = Dak.last(20)
		dak_data.each do |data|
			if data.dak_receivers.blank? or data.dak_attachments.blank?
				DakReceiver.where(id: data.dak_receivers.pluck(:id)).destroy_all if data.dak_receivers.present?
				DakAttachment.where(id: data.dak_attachments.pluck(:id)).destroy_all if data.dak_attachments.present?
				Dak.find(data.id).destroy
			end
		end	
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
