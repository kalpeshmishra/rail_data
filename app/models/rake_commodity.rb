class RakeCommodity < ApplicationRecord
  belongs_to :major_commodity


    def self.set_rake_commodity_upload(params)
    
    upload_file = params[:rake_commodity_attachment] 
    if upload_file.present?
      today = Date.today
      random_string = SecureRandom.hex
      File.open("public/report_content_#{random_string}.xls", 'wb') { |f| f.write(upload_file.read) }
      extra_params = [upload_file.original_filename, upload_file.path]
      spreadsheet = ApplicationController.new.open_spreadsheet(extra_params[0], extra_params[1]) rescue nil
      if spreadsheet.nil? or spreadsheet.include?("Unknown file type:")
        result = {['NA', 'NA', 'NA', 'NA'] => "#{spreadsheet}"}
      else
        result = self.rake_commodity_upload(spreadsheet)
        
      end

    else
    end
  end

  def self.rake_commodity_upload(sheet)
    
    sheet.each_with_index do |row, index|
      next if index == 0
      sr_no = row[0] 

      major_commodity = row[1]
      group_rake_commodity = row[2] 
      rake_commodity_code = row[3]
      rake_commodity_name = row[4]

      major_commodity_hash = {}
      MajorCommodity.all.map{|major_commodity| major_commodity_hash[major_commodity.major_commodity] = {id: major_commodity.id}}
      major_commodity_id = major_commodity_hash[major_commodity][:id] rescue nil
      
      RakeCommodity.create(major_commodity_id: major_commodity_id,group_rake_commodity: group_rake_commodity,rake_commodity_code: rake_commodity_code,rake_commodity_name: rake_commodity_name)
    end 
  end
end
