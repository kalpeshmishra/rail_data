class Admin::LoadingReportsController < ApplicationController
	layout "admin/application"

	def index
		data = params[:data].to_date if params[:data].present?
    data = Date.today if data.blank?

    @rake_loads = RakeLoad.where(RakeLoad.arel_table[:arrival_date].lteq(data).and(RakeLoad.arel_table[:release_date].eq(data)))
    @rake_loads += RakeLoad.where(RakeLoad.arel_table[:arrival_date].lteq(data).and(RakeLoad.arel_table[:release_date].eq(nil)))
    @rake_loads += RakeLoad.where(RakeLoad.arel_table[:arrival_date].lteq(data).and(RakeLoad.arel_table[:release_date].eq("")))
    @rake_loads += RakeLoad.where(RakeLoad.arel_table[:arrival_date].eq(nil).and(RakeLoad.arel_table[:release_date].eq(data)))
    if data == Date.today
      @rake_loads += RakeLoad.where(RakeLoad.arel_table[:arrival_date].eq(nil).and(RakeLoad.arel_table[:release_date].eq(nil)))
    end
    adi_area_loads =[]
    gimb_area_loads =[]

    adi_unit = 0
    gimb_unit = 0
    adi_rake = 0
    gimb_rake = 0
    @rake_loads.each do |rake_load|
    	rake_area =  rake_load.load_unload.station.area.area_code rescue nil
    	if rake_area == "ADI"
    		adi_area_loads << rake_load
    		adi_unit = adi_unit + rake_load.loaded_unit
        adi_rake = adi_rake + rake_load.rake_count
    	elsif rake_area == "GIMB"
    		gimb_area_loads << rake_load
    		gimb_unit = gimb_unit + rake_load.loaded_unit
        gimb_rake = gimb_rake + rake_load.rake_count
    	end
    end
    @adi_loads = adi_area_loads
    @gimb_loads = gimb_area_loads
    
    @total_adi_loads = adi_unit
    @total_adi_rake = adi_rake
		@total_gimb_loads = gimb_unit
    @total_gimb_rake = gimb_rake
    @total_division_loads = adi_unit+ gimb_unit
    @total_division_rake = adi_rake + gimb_rake

    # if params[:is_division_report_type].present?
      # rake_load_excel_download(params)
    # end

  end

  # def rake_load_excel_download
  #   require 'roo'

  #   statement_xls = Spreadsheet::Workbook.new
  #   sheet = statement_xls.create_worksheet :name => "DayWiseLoadingReport"

  #   header = ["SrNo.", "From ", "To   ", "Rake", "Unit", "Stock", "Commodity","ODR","Arrival Time/Date","Placement Time/Date", "Release Time/Date","ShortRouteIC", "Short Km"]


  #   sheet.row(0).default_format = Spreadsheet::Format.new(:weight => :bold)

  #   header.each_with_index do |label, index|
  #     sheet[0, index] = label
  #     header_width = label.length + 2
  #     sheet.column(index).width = header_width
      
  #   end
  #   row_count = 0
  #   @rake_loads.each_with_index do |rake_load, index|
  #     row_count = index + 1
  #   # binding.pry
  #     rake_load_row_values = [row_count,rake_load.load_unload.station.code, rake_load.station.code, rake_load.rake_count, rake_load.loaded_unit, rake_load.wagon_type.wagon_type_code, rake_load.major_commodity.major_commodity, rake_load.odr_type, rake_load.arrival_time.first(5)+" "+ rake_load.arrival_date.strftime('%d-%m-%y'), rake_load.placement_time.first(5)+" "+ rake_load.placement_date.strftime('%d-%m-%y'), rake_load.release_time.first(5)+" "+rake_load.release_date.strftime('%d-%m-%y'), rake_load.short_interchange, rake_load.short_km]
  #     rake_load_row_values.each_with_index do |content, index|
  #         sheet[row_count, index] = content
  #     end
  #   end

    # statement_xls.write "public/report_content.xls"
    # send_file "public/report_content.xls", :type => "application/vnd.ms-excel", :filename => "rake_load.xls", disposition: 'attachment'
    # statement_xls
  # end

  def rake_load_excel_download
    # binding.pry
      require 'roo'
      statement_xls = Spreadsheet::Workbook.new
      sheet = statement_xls.create_worksheet :name => "ESIC Monthly Contribution"

      header = ["IP Number", "IP Name", "IP Code", "Days for which wage paid in month", "Total Monthly Wages", "Reason Code for Zero Working days", "Last Working Day"]


      sheet.row(0).default_format = Spreadsheet::Format.new(:weight => :bold)

      header.each_with_index do |label, index|
      sheet[0, index] = label
      sheet.column(index).width = 30
      end
      report_content = statement_xls
      report_content.write "public/report_content.xls"
     send_file "public/report_content.xls", :type => "application/vnd.ms-excel", :filename => "pratikchauhan.xls", disposition: 'attachment'
  end
  

  def show
    
  end
end
