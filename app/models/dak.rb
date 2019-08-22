class Dak < ApplicationRecord
	belongs_to :user
	has_many :dak_receivers
	has_many :dak_attachments

	def self.create_dak_data(params,user_id)

		temp_list = params.values.select {|item| 
									if item.class != ActionDispatch::Http::UploadedFile
										item.include?("select_recipient")
									end
								}

		file_list = params.values.select {|item| 
									if item.class == ActionDispatch::Http::UploadedFile
										item
									end
								}							

		select_user_id = []
		temp_list.each do |v|
			v = v.split("_")
			select_user_id << v[2].to_i
		end
		
		dak_data = self.new
		dak_data.letter_type = params["letter_type"] rescue nil
		dak_data.letter_number = params["letter_number"] rescue nil
		dak_data.letter_issue_date = params["letter_date"].to_date rescue nil
		dak_data.letter_description = params["subject"] rescue nil
		dak_data.creater_user_id = user_id.to_i
		dak_data.save

		accepted_formats = %w(.pdf .xls .xlsx .csv .doc .docx .odt .jpg .jpeg .png)

		if dak_data.save
			select_user_id.each do |reciever_id|
				DakReceiver.create(dak_id: dak_data.id,reciever_user_id: reciever_id,is_read: false)
			end
			binding.pry
			file_list.count.times do |file_count|	
				# file_count = file_count+1
				value = params["user_attachment_#{file_count}"]
	      name = value.original_filename rescue ''
	      raise 'Unacceptable File Format.' unless accepted_formats.include? File.extname(name).downcase
	      raise "File size must be less than 7MB." if value.size > 7.megabytes
	      FileUtils::mkdir_p "public/dak_files/#{user_id}/"
	      path = File.join("public/dak_files/#{user_id}/", "#{dak_data.id.to_s}-#{file_count.to_s}-#{name}")
	      File.open(path, "wb") { |f| f.write(value.read) }
	      
	      DakAttachment.create(dak_id: dak_data.id, attachment_type: File.extname(name).downcase, attachment_path: path) 
		  end 

		end
			
	end




end
