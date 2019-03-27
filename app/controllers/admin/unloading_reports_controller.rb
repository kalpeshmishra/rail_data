class Admin::UnloadingReportsController < ApplicationController
	layout "admin/application"

	def index
		data = params[:data].to_date if params[:data].present?
    data = Date.today if data.blank?
    # binding.pry
    @rake_unloads = RakeUnload.where(RakeUnload.arel_table[:arrival_date].lteq(data).and(RakeUnload.arel_table[:release_date].eq(data)))
    @rake_unloads += RakeUnload.where(RakeUnload.arel_table[:arrival_date].lteq(data).and(RakeUnload.arel_table[:release_date].eq(nil)))
    @rake_unloads += RakeUnload.where(RakeUnload.arel_table[:arrival_date].lteq(data).and(RakeUnload.arel_table[:release_date].eq("")))
    @rake_unloads += RakeUnload.where(RakeUnload.arel_table[:arrival_date].eq(nil).and(RakeUnload.arel_table[:release_date].eq(data)))
    @rake_unloads += RakeUnload.where(RakeUnload.arel_table[:arrival_date].eq(nil).and(RakeUnload.arel_table[:release_date].eq(nil)))
    
    adi_area_unloads =[]
    gimb_area_unloads =[]

    adi_unit = 0
    gimb_unit = 0
    @rake_unloads.each do |rake_unload|
    	rake_area =  rake_unload.load_unload.station.area.area_code rescue nil
    	if rake_area == "ADI"
    		adi_area_unloads << rake_unload
    		adi_unit = adi_unit + rake_unload.loaded_unit
    	elsif rake_area == "GIMB"
    		gimb_area_unloads << rake_unload
    		gimb_unit = gimb_unit + rake_unload.loaded_unit
    	end
    end
    @adi_unloads = adi_area_unloads.sort_by(&:load_unload_id)
    @gimb_unloads = gimb_area_unloads
    
    @total_adi_unloads = adi_unit
		@total_gimb_unloads = gimb_unit
    @total_rake_unloads = adi_unit + gimb_unit 

    @abc_summary_date = data if data.present?
    abc_summary_data  = get_abc_summary_data(data)
    @adi_abc_summary_data  = abc_summary_data[0]
    @gimb_abc_summary_data  = abc_summary_data[1]
  end
  
  def get_abc_summary_data(data)
    previous_stock = RakeUnload.where(RakeUnload.arel_table[:placement_date].lt(data).and(RakeUnload.arel_table[:release_date].gteq(data)))
    previous_stock += RakeUnload.where(RakeUnload.arel_table[:placement_date].lt(data).and(RakeUnload.arel_table[:release_date].eq(nil)))
    previous_stock += RakeUnload.where(RakeUnload.arel_table[:placement_date].lt(data).and(RakeUnload.arel_table[:release_date].eq("")))
    
    received_stock = RakeUnload.where(RakeUnload.arel_table[:placement_date].eq(data))
    release_stock = RakeUnload.where(RakeUnload.arel_table[:release_date].eq(data))

    onhand_stock = RakeUnload.where(RakeUnload.arel_table[:placement_date].lteq(data).and(RakeUnload.arel_table[:release_date].gt(data)))
    onhand_stock += RakeUnload.where(RakeUnload.arel_table[:placement_date].lteq(data).and(RakeUnload.arel_table[:release_date].eq(nil)))
    onhand_stock += RakeUnload.where(RakeUnload.arel_table[:placement_date].lteq(data).and(RakeUnload.arel_table[:release_date].eq("")))
    
    all_stock = previous_stock + received_stock + release_stock + onhand_stock
    adi_stations = []
    gimb_stations = []
    all_stock.each do |rake_unload|
      rake_area =  rake_unload.load_unload.station.area.area_code 
      if rake_area == "ADI"
        adi_stations << [rake_unload.load_unload_id,rake_unload.load_unload.station.code]
      elsif rake_area == "GIMB"
        gimb_stations << [rake_unload.load_unload_id,rake_unload.load_unload.station.code]
      end
    end
    
    adi_stations = adi_stations.uniq  
    gimb_stations = gimb_stations.uniq

    adi_abc_hash_data = get_area_hash_data(adi_stations,previous_stock,received_stock,release_stock,onhand_stock)
    gimb_abc_hash_data = get_area_hash_data(gimb_stations,previous_stock,received_stock,release_stock,onhand_stock)
    return adi_abc_hash_data,gimb_abc_hash_data
    
  end

  def get_area_hash_data(area_stations,previous_stock,received_stock,release_stock,onhand_stock)
    area_data_hash = {}
    if area_stations.present?
      area_stations.each do|unload_id,station|
        area_data_hash[station] ={}
        area_data_hash[station].merge!("previous_stock" => {})
        area_data_hash[station].merge!("received_stock" => {})
        area_data_hash[station].merge!("release_stock" => {})
        area_data_hash[station].merge!("onhand_stock" => {})
      end
      
      previous_stock.each do |rake_unload|
        if area_stations.transpose[0].include?(rake_unload.load_unload_id)
          station = rake_unload.load_unload.station.code
          stock_type = WagonType.find(rake_unload.wagon_type_id).wagon_details_covered_open
          loaded_unit = rake_unload.loaded_unit
          if area_data_hash[station]["previous_stock"][stock_type].blank?
            area_data_hash[station]["previous_stock"].merge!(stock_type => loaded_unit)
          else
            final = area_data_hash[station]["previous_stock"][stock_type] + loaded_unit
            area_data_hash[station]["previous_stock"][stock_type]  = final
          end
        end
      end
      received_stock.each do |rake_unload|
        if area_stations.transpose[0].include?(rake_unload.load_unload_id)
          station = rake_unload.load_unload.station.code
          stock_type = WagonType.find(rake_unload.wagon_type_id).wagon_details_covered_open
          loaded_unit = rake_unload.loaded_unit
          if area_data_hash[station]["received_stock"][stock_type].blank?
            area_data_hash[station]["received_stock"].merge!(stock_type => loaded_unit)
          else
            final = area_data_hash[station]["received_stock"][stock_type] + loaded_unit
            area_data_hash[station]["received_stock"][stock_type]  = final
          end
        end
      end
      release_stock.each do |rake_unload|
        if area_stations.transpose[0].include?(rake_unload.load_unload_id)
          station = rake_unload.load_unload.station.code
          stock_type = WagonType.find(rake_unload.wagon_type_id).wagon_details_covered_open
          loaded_unit = rake_unload.loaded_unit
          if area_data_hash[station]["release_stock"][stock_type].blank?
            area_data_hash[station]["release_stock"].merge!(stock_type => loaded_unit)
          else
            final = area_data_hash[station]["release_stock"][stock_type] + loaded_unit
            area_data_hash[station]["release_stock"][stock_type]  = final
          end
        end
      end
      onhand_stock.each do |rake_unload|
        if area_stations.transpose[0].include?(rake_unload.load_unload_id)
          station = rake_unload.load_unload.station.code
          stock_type = WagonType.find(rake_unload.wagon_type_id).wagon_details_covered_open
          loaded_unit = rake_unload.loaded_unit
          if area_data_hash[station]["onhand_stock"][stock_type].blank?
            area_data_hash[station]["onhand_stock"].merge!(stock_type => loaded_unit)
          else
            final = area_data_hash[station]["onhand_stock"][stock_type] + loaded_unit
            area_data_hash[station]["onhand_stock"][stock_type]  = final
          end
        end
      end
      return area_data_hash
        
    end
    
  end  

   def abc_unload_summary_pdf
    
    data = params[:date].split(",")[0].to_date if params[:date].present?
    data = Date.today if data.blank?
    @abc_summary_date = data if data.present?
    abc_summary_data  = get_abc_summary_data(data)
    @adi_abc_summary_data  = abc_summary_data[0]
    @gimb_abc_summary_data  = abc_summary_data[1]
    
    render :pdf => "#{data}-ABC-PU-Summary",
           :template => "admin/unloading_reports/abc_unload_summary_pdf.pdf.erb",
           :disposition => 'attachment',
           :show_as_html => params.key?('debug'),
           :layout => nil
  end


  def show
    
  end
end
