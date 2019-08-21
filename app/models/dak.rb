class Dak < ApplicationRecord
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



		if dak_data.save
			select_user_id.each do |reciever_id|
				DakReceiver.create(dak_id: dak_data.id,reciever_user_id: reciever_id,is_read: false)
			end

				
		    @creater_id = user_id.to_i
		    	binding.pry
		  		dak_attah = DakAttachment.new
		    # unless params[:value] == ""
		      value = params[:user_attachment_0]
		      name = value.original_filename rescue ''
		      # raise 'Unacceptable File Format.' unless accepted_formats.include? File.extname(name).downcase
		      raise "File size must be less than 7MB." if value.size > 7.megabytes
		      document_aws_path = "dak_files/#{@creater_id.to_s}/#{dak_data.id.to_s}-#{name}"
		      path = File.join("public/dak_files/#{@creater_id.to_s}/", "#{dak_data.id.to_s}-#{name}")
		      # mkdir "public/dak_files/#{@creater_id.to_s}/"
		      File.open(path, "wb") { |f| f.write(value.read) }
		      # ::FogUpload.create(document_aws_path, File.open("public/dak_files/#{user_id}-#{dak_data.id.to_s}-#{name}"))
		      dak_attah.dak_id = dak_data.id
		      dak_attah.attachment_type = File.extname(name).downcase
		      dak_attah.attachment_path = document_aws_path
		      dak_attah.save!
		    # end
			




		end
			
	end




end
