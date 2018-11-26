class MajorCommodity < ApplicationRecord
  has_many :rake_commodities
  has_many :rake_loads
  has_many :rake_unloads

    def self.set_major_commodity_upload(params)
    
    upload_file = params[:major_commodity_attachment] 
    if upload_file.present?
      today = Date.today
      random_string = SecureRandom.hex
      File.open("public/report_content_#{random_string}.xls", 'wb') { |f| f.write(upload_file.read) }
      extra_params = [upload_file.original_filename, upload_file.path]
      spreadsheet = ApplicationController.new.open_spreadsheet(extra_params[0], extra_params[1]) rescue nil
      if spreadsheet.nil? or spreadsheet.include?("Unknown file type:")
        result = {['NA', 'NA', 'NA', 'NA'] => "#{spreadsheet}"}
      else
        result = self.major_commodity_upload(spreadsheet)
        
      end

    else
    end
  end

  def self.major_commodity_upload(sheet)
    
    sheet.each_with_index do |row, index|
      next if index == 0
      sr_no = row[0] 
      major_commodity = row[1] 
      name = row[2]
      
      
      MajorCommodity.create(major_commodity: major_commodity,name: name)
    end 
  end
end
