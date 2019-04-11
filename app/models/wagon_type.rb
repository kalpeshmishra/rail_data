class WagonType < ApplicationRecord
  has_many :rake_loads
  has_many :month_rake_loads
  has_many :rake_unloads
  has_many :load_interchanges

  def self.set_wagon_type_upload(params)
    
    upload_file = params[:wagon_type_attachment] 
    if upload_file.present?
      today = Date.today
      random_string = SecureRandom.hex
      File.open("public/report_content_#{random_string}.xls", 'wb') { |f| f.write(upload_file.read) }
      extra_params = [upload_file.original_filename, upload_file.path]
      spreadsheet = ApplicationController.new.open_spreadsheet(extra_params[0], extra_params[1]) rescue nil
      if spreadsheet.nil? or spreadsheet.include?("Unknown file type:")
        result = {['NA', 'NA', 'NA', 'NA'] => "#{spreadsheet}"}
      else
        result = self.wagon_type_upload(spreadsheet)
        
      end

    else
    end
  end

  def self.wagon_type_upload(sheet)
    
    sheet.each_with_index do |row, index|
      next if index == 0
      sr_no = row[0] 
      group_rake_type = row[1]
      rake_type = row[2]
      stock_type_code = row[3]
      wagon_type_code = row[4]
      wagon_type_desc = row[5]
      wagon_details_brake_type = row[6]
      wagon_details_covered_open = row[7]
      wagon_details_min_max_tare = row[8]
      allowed_cmdt = row[9]
      load_class_wagon = row[10]
      load_class_train = row[11]
      
      
      WagonType.create(group_rake_type: group_rake_type, rake_type: rake_type, stock_type_code: stock_type_code, wagon_type_code: wagon_type_code, wagon_type_desc: wagon_type_desc, wagon_details_brake_type: wagon_details_brake_type, wagon_details_covered_open: wagon_details_covered_open, wagon_details_min_max_tare: wagon_details_min_max_tare, allowed_cmdt: allowed_cmdt, load_class_wagon: load_class_wagon, load_class_train: load_class_train)
    end 
  end

end
