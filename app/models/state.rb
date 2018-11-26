class State < ApplicationRecord

  has_many :stations



  def self.set_state_upload(params)
    
    upload_file = params[:state_attachment] 
    if upload_file.present?
      today = Date.today
      random_string = SecureRandom.hex
      File.open("public/report_content_#{random_string}.xls", 'wb') { |f| f.write(upload_file.read) }
      extra_params = [upload_file.original_filename, upload_file.path]
      spreadsheet = ApplicationController.new.open_spreadsheet(extra_params[0], extra_params[1]) rescue nil
      if spreadsheet.nil? or spreadsheet.include?("Unknown file type:")
        result = {['NA', 'NA', 'NA', 'NA'] => "#{spreadsheet}"}
      else
        result = self.state_upload(spreadsheet)
        
      end

    else
    end
  end

  def self.state_upload(sheet)
    
    sheet.each_with_index do |row, index|
      next if index == 0
      sr_no = row[0] 
      name = row[1] 
      code = row[2]
      alternative_code = row[3]
      
      State.create(name: name,code: code)
    end 
  end
end
