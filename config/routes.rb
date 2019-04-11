Rails.application.routes.draw do
	
  #devise_for :models
  devise_for :users
  root :to => 'home#index'
  
  

  match '/get_division', controller: 'admin/areas', action: 'get_division', via: [:get], as: 'get_division'
  
  match '/find_station', controller: 'admin/rake_loads', action: 'find_station', via: [:get], as: 'find_station'
  match '/find_from_station', controller: 'admin/rake_loads', action: 'find_from_station', via: [:get], as: 'find_from_station'
  match '/delete_rake_load', controller: 'admin/rake_loads', action: 'delete_rake_load', via: [:get], as: 'delete_rake_load'
  
  match '/find_to_station_other_loads', controller: 'admin/other_loads', action: 'find_to_station_other_loads', via: [:get], as: 'find_to_station_other_loads'
  match '/find_from_station_other_loads', controller: 'admin/other_loads', action: 'find_from_station_other_loads', via: [:get], as: 'find_from_station_other_loads'
  match '/delete_other_load', controller: 'admin/other_loads', action: 'delete_other_load', via: [:get], as: 'delete_other_load'
  
  match '/load_commodity_breakup', controller: 'admin/one_rake_loads', action: 'load_commodity_breakup', via: [:get], as: 'load_commodity_breakup'
    

  match '/find_station_unloads', controller: 'admin/rake_unloads', action: 'find_station_unloads', via: [:get], as: 'find_station_unloads'
  match '/find_from_station_unloads', controller: 'admin/rake_unloads', action: 'find_from_station_unloads', via: [:get], as: 'find_from_station_unloads'
  match '/delete_rake_unload', controller: 'admin/rake_unloads', action: 'delete_rake_unload', via: [:get], as: 'delete_rake_unload'
  
  match '/find_to_station_other_unloads', controller: 'admin/other_unloads', action: 'find_to_station_other_unloads', via: [:get], as: 'find_to_station_other_unloads'
  match '/find_from_station_other_unloads', controller: 'admin/other_unloads', action: 'find_from_station_other_unloads', via: [:get], as: 'find_from_station_other_unloads'
  match '/delete_other_unload', controller: 'admin/other_unloads', action: 'delete_other_unload', via: [:get], as: 'delete_other_unload'
  

  match '/find_to_station_gets_unloads', controller: 'admin/gets_unloads', action: 'find_to_station_gets_unloads', via: [:get], as: 'find_to_station_gets_unloads'
  match '/find_from_station_gets_unloads', controller: 'admin/gets_unloads', action: 'find_from_station_gets_unloads', via: [:get], as: 'find_from_station_gets_unloads'
  match '/delete_gets_unload', controller: 'admin/gets_unloads', action: 'delete_gets_unload', via: [:get], as: 'delete_gets_unload'
  
  match '/find_to_station_aecs_unloads', controller: 'admin/aecs_unloads', action: 'find_to_station_aecs_unloads', via: [:get], as: 'find_to_station_aecs_unloads'
  match '/find_from_station_aecs_unloads', controller: 'admin/aecs_unloads', action: 'find_from_station_aecs_unloads', via: [:get], as: 'find_from_station_aecs_unloads'
  match '/delete_aecs_unload', controller: 'admin/aecs_unloads', action: 'delete_aecs_unload', via: [:get], as: 'delete_aecs_unload'

  #--------------Excel Reports Download Starts-----------------
  match '/rake_load_excel_download', controller: 'admin/loading_reports', action: 'rake_load_excel_download', via: [:get], as: 'rake_load_excel_download'
  match '/custom_load_report_excel_download', controller: 'admin/custom_load_reports', action: 'custom_load_report_excel_download', via: [:get], as: 'custom_load_report_excel_download'
  match '/month_custom_load_report_excel_download', controller: 'admin/custom_load_reports', action: 'month_custom_load_report_excel_download', via: [:get], as: 'month_custom_load_report_excel_download'
  #--------------Excel Reports Download Ends-----------------

  #--------------PDF Reports Download Starts-----------------
  match '/download_summary_pdf', controller: 'admin/loading_reports', action: 'download_summary_pdf', via: [:get], as: 'download_summary_pdf'
  match '/abc_unload_summary_pdf', controller: 'admin/unloading_reports', action: 'abc_unload_summary_pdf', via: [:get], as: 'abc_unload_summary_pdf'
  #--------------PDF Reports Download Ends-----------------

  namespace :admin do
  	resources :railway_zones,:states,:divisions, :areas,:stations,:rake_commodities,:major_commodities, :wagon_types, :load_unloads, :rake_loads, :rake_unloads, :other_loads, :one_rake_loads, :two_rake_loads, :one_rake_unloads, :other_unloads, :gets_unloads, :aecs_unloads, :short_routes, :ic_divisions, :users, :user_roles, :loading_reports,:unloading_reports, :phasewise_reports, :one_loading_reports, :one_unloading_reports, :custom_reports, :one_custom_reports, :custom_load_reports, :month_rake_loads, :two_custom_reports, :load_interchanges
  end

  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
