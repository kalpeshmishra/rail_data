# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20200320112919) do

  create_table "allowance_summaries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "employee_category_id"
    t.integer  "station_id"
    t.string   "month"
    t.string   "over_time_hours"
    t.string   "over_time_minutes"
    t.string   "over_time_amount"
    t.string   "transpotation_days"
    t.string   "transpotation_amount"
    t.string   "contingency_amount"
    t.string   "extra"
    t.string   "remark"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "areas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "railway_zone_id"
    t.integer  "division_id"
    t.string   "area_code"
    t.string   "area_name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "audits", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes", limit: 65535
    t.integer  "version",                       default: 0
    t.string   "comment"
    t.string   "remote_address"
    t.string   "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index", using: :btree
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index", using: :btree
    t.index ["created_at"], name: "index_audits_on_created_at", using: :btree
    t.index ["request_uuid"], name: "index_audits_on_request_uuid", using: :btree
    t.index ["user_id", "user_type"], name: "user_index", using: :btree
  end

  create_table "crack_rakes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "train_name"
    t.string   "power_number"
    t.string   "stock_type"
    t.string   "order_time"
    t.date     "order_date"
    t.string   "on_duty_time"
    t.date     "on_duty_date"
    t.string   "pre_departure_detnention"
    t.string   "departure_station"
    t.string   "departure_time"
    t.date     "departure_date"
    t.string   "dhg_arrival_time"
    t.date     "dhg_arrival_date"
    t.string   "tor_departure_dhg_arrival"
    t.string   "gimb_arrival_time"
    t.date     "gimb_arrival_date"
    t.string   "off_duty_time"
    t.date     "off_duty_date"
    t.string   "detention_on_to_off_duty"
    t.string   "tor_departure_gimb_arrival"
    t.string   "remarks"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "create_rake_loads_rake_commodities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "rake_load_id"
    t.integer  "rake_commodity_id"
    t.integer  "rake_unit"
    t.float    "commodity_rake_count", limit: 24
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "create_rake_loads_wagon_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "rake_load_id"
    t.integer  "wagon_type_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "dak_attachments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "dak_id"
    t.string   "attachment_type"
    t.string   "attachment_path"
    t.string   "extra_path"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "dak_receivers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "dak_id"
    t.integer  "reciever_user_id"
    t.boolean  "is_read"
    t.datetime "dak_read_time_date"
    t.string   "extra"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "daks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "letter_type"
    t.string   "letter_number"
    t.string   "letter_issue_date"
    t.string   "letter_description"
    t.integer  "creater_user_id"
    t.datetime "dak_create_at"
    t.string   "extra"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "divisions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "code"
    t.string   "zone_headquarter"
    t.string   "desc"
    t.integer  "railway_zone_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "employee_allowances", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "employee_id"
    t.integer  "employee_post_id"
    t.integer  "station_id"
    t.string   "month"
    t.string   "over_time_hours"
    t.string   "over_time_minutes"
    t.string   "over_time_amount"
    t.string   "transpotation_days"
    t.string   "transpotation_amount"
    t.string   "contingency_amount"
    t.string   "extra"
    t.string   "reason"
    t.string   "remark"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "employee_award_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "employee_id"
    t.string   "award_category"
    t.date     "award_date"
    t.text     "reason",         limit: 65535
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "employee_cadres", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "station_id"
    t.integer  "employee_post_id"
    t.integer  "number_of_post"
    t.string   "remark"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "employee_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "employee_department_id"
    t.string   "name"
    t.string   "group"
    t.string   "report_group"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "employee_category_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "employee_id"
    t.string   "category_type"
    t.date     "date_in_level"
    t.integer  "employee_post_id"
    t.string   "letter_number"
    t.date     "letter_date"
    t.string   "remark"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "employee_dar_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "employee_id"
    t.string   "dar_type"
    t.date     "issue_date"
    t.date     "received_at_station"
    t.date     "acknowledge_by_employee"
    t.date     "defense_submit_by_employee"
    t.date     "employee_defense_sent_to_dar"
    t.date     "nip_received_date"
    t.date     "nip_acknowledge_sent_to_dar"
    t.date     "sf_7_issue"
    t.date     "finding_report_issue_date"
    t.date     "acknowledge_finding_report"
    t.string   "remark"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "employee_departments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employee_family_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "employee_id"
    t.string   "name"
    t.string   "relation"
    t.string   "gender"
    t.string   "marital_status"
    t.string   "dependancy"
    t.string   "physicaly_challanged"
    t.string   "blood_group"
    t.string   "aadhaar"
    t.string   "mobile"
    t.date     "birth_date"
    t.string   "remarks"
    t.string   "extra"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "employee_medical_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "employee_id"
    t.integer  "employee_category_id"
    t.string   "medical_type"
    t.string   "medical_category"
    t.date     "medical_date"
    t.date     "fit_date"
    t.date     "next_due_date"
    t.string   "certificate_no"
    t.string   "issued_by"
    t.string   "remark"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "employee_posts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "employee_department_id"
    t.integer  "employee_category_id"
    t.string   "group"
    t.string   "post"
    t.string   "post_code"
    t.string   "pay_band_p6"
    t.string   "grade_pay_p6"
    t.integer  "level_p7"
    t.string   "report_group"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "employee_training_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "employee_id"
    t.integer  "employee_category_id"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "training_type"
    t.date     "next_due_date"
    t.string   "certificate_no"
    t.string   "grade_received"
    t.string   "training_center"
    t.string   "remark"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "employee_transfer_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "employee_id"
    t.integer  "station_id"
    t.string   "transfer_type"
    t.date     "resume_date"
    t.date     "relieve_date"
    t.date     "transfer_date"
    t.string   "letter_number"
    t.string   "remark"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "employees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "father_name"
    t.string   "spouse_name"
    t.string   "mother_name"
    t.string   "emp_number"
    t.string   "pran_number"
    t.string   "pan_number"
    t.string   "aadhaar"
    t.string   "gender"
    t.string   "religion"
    t.string   "community"
    t.date     "birth_date"
    t.string   "marital_status"
    t.string   "disability"
    t.date     "appointment_date"
    t.string   "permanent_address"
    t.string   "temporary_address"
    t.string   "mobile_no"
    t.string   "alternate_number"
    t.string   "email_id"
    t.string   "appointment_mode"
    t.integer  "employee_post_id"
    t.integer  "station_id"
    t.string   "image_path"
    t.string   "in_service"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "ic_divisions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "railway_zone_id"
    t.integer  "division_id"
    t.string   "from_section"
    t.string   "ic_code"
    t.string   "ic_name"
    t.string   "to_section"
    t.string   "to_division"
    t.string   "to_zone"
    t.string   "ic_by"
    t.string   "interchange_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "ic_zones", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "railway_zone_id"
    t.integer  "division_id"
    t.string   "ic_code"
    t.string   "ic_name"
    t.string   "to_division"
    t.string   "to_zone"
    t.string   "ic_by"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "load_interchanges", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date     "interchange_date"
    t.string   "interchange_type"
    t.string   "interchange_point"
    t.string   "interchange_point_type"
    t.integer  "wagon_type_id"
    t.string   "stock_details"
    t.float    "rakes",                  limit: 24
    t.integer  "units"
    t.integer  "extra"
    t.string   "extra_one"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "load_unloads", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "station_name"
    t.string   "serving_station"
    t.integer  "station_id"
    t.integer  "area_id"
    t.integer  "division_id"
    t.string   "status"
    t.string   "desc"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "major_commodities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "major_commodity"
    t.string   "name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "models", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "is_admin"
    t.boolean  "is_super_admin"
    t.boolean  "is_sub_admin"
    t.boolean  "is_user"
    t.boolean  "is_area_user"
    t.boolean  "is_division_user"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_models_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_models_on_reset_password_token", unique: true, using: :btree
  end

  create_table "month_phasewise_rake_loads", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "load_month"
    t.integer  "load_unload_id"
    t.string   "commodity_type"
    t.float    "rake_count",                       limit: 24
    t.integer  "loaded_unit"
    t.string   "detention_arrival_placement"
    t.string   "detention_placement_release"
    t.string   "detention_release_departure"
    t.string   "detention_release_removal"
    t.string   "detention_removal_departure"
    t.string   "detention_release_powerarrival"
    t.string   "detention_powerarrival_departure"
    t.string   "extra"
    t.string   "extra_one"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  create_table "month_rake_loads", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "load_month"
    t.integer  "load_unload_id"
    t.integer  "station_id"
    t.integer  "loaded_unit"
    t.integer  "total_unit"
    t.integer  "wagon_type_id"
    t.integer  "major_commodity_id"
    t.integer  "double_stack"
    t.float    "gross_tons",         limit: 24
    t.float    "net_tons",           limit: 24
    t.float    "rake_count",         limit: 24
    t.integer  "tue_first_row"
    t.integer  "tue_second_row"
    t.string   "extra"
    t.string   "extra_one"
    t.string   "extra_two"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "railway_zones", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "code"
    t.string   "zone_headquarter"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "rake_commodities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "major_commodity_id"
    t.string   "group_rake_commodity"
    t.string   "rake_commodity_code"
    t.string   "rake_commodity_name"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "rake_load_commodities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "rake_load_id"
    t.integer  "rake_commodity_id"
    t.string   "group_rake_commodity"
    t.string   "commodity_name"
    t.string   "commodity_full_name"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "rake_loads", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "load_unload_id"
    t.integer  "station_id"
    t.date     "forecast_date"
    t.string   "rake_received"
    t.integer  "loaded_unit"
    t.integer  "total_unit"
    t.integer  "wagon_type_id"
    t.integer  "major_commodity_id"
    t.float    "gross_tons",                       limit: 24
    t.float    "net_tons",                         limit: 24
    t.float    "rake_count",                       limit: 24
    t.string   "stack"
    t.string   "arrival_time"
    t.date     "arrival_date"
    t.string   "placement_time"
    t.date     "placement_date"
    t.string   "release_time"
    t.date     "release_date"
    t.string   "powerarrival_time"
    t.date     "powerarrival_date"
    t.string   "removal_time"
    t.date     "removal_date"
    t.string   "departure_time"
    t.date     "departure_date"
    t.integer  "power_no"
    t.string   "bpc_type"
    t.string   "bpc_station"
    t.date     "bpc_date"
    t.integer  "tue_first_row"
    t.integer  "tue_second_row"
    t.string   "commodity_type"
    t.string   "odr_type"
    t.string   "odr_time"
    t.date     "odr_date"
    t.string   "consignor"
    t.string   "consignee"
    t.string   "actual_interchange"
    t.string   "ic_time"
    t.date     "ic_date"
    t.string   "short_interchange"
    t.float    "short_km",                         limit: 24
    t.string   "rake_loading_id"
    t.string   "back_loading"
    t.string   "remark"
    t.string   "rakeform_otherform"
    t.string   "detention_arrival_placement"
    t.string   "detention_placement_release"
    t.string   "detention_release_removal"
    t.string   "detention_removal_departure"
    t.string   "detention_release_powerarrival"
    t.string   "detention_powerarrival_departure"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.float    "freight",                          limit: 24
    t.string   "extra"
  end

  create_table "rake_unloads", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "takenover_point"
    t.string   "takenover_time"
    t.date     "takenover_date"
    t.string   "train_on_run_hours"
    t.string   "empty_destination"
    t.string   "handedover_point"
    t.string   "handedover_time"
    t.date     "handedover_date"
    t.string   "detention_ger_to_ger_tor"
    t.integer  "station_id"
    t.integer  "load_unload_id"
    t.integer  "loaded_unit"
    t.integer  "total_unit"
    t.integer  "wagon_type_id"
    t.string   "stock_description"
    t.float    "rake_count",                   limit: 24
    t.integer  "major_commodity_id"
    t.string   "stack"
    t.integer  "tue_first_row"
    t.integer  "tue_second_row"
    t.string   "arrival_time"
    t.date     "arrival_date"
    t.string   "placement_time"
    t.date     "placement_date"
    t.string   "release_time"
    t.date     "release_date"
    t.string   "bpc_type"
    t.string   "bpc_station"
    t.date     "bpc_date"
    t.string   "bpc_validity"
    t.string   "empty_rake_release_id"
    t.string   "removal_time"
    t.date     "removal_date"
    t.string   "commodity_breakup"
    t.string   "commodity_type"
    t.string   "collary"
    t.string   "consignor"
    t.string   "consignee"
    t.string   "status"
    t.integer  "power_no"
    t.string   "powerarrival_time"
    t.date     "powerarrival_date"
    t.string   "stable_time"
    t.date     "stable_date"
    t.string   "departure_time"
    t.date     "departure_date"
    t.string   "remarks"
    t.string   "form_status"
    t.string   "detention_arrival_placement"
    t.string   "detention_placement_release"
    t.string   "detention_release_removal"
    t.string   "detention_removal_departure"
    t.string   "detention_for_power"
    t.string   "powerarrival_train_departure"
    t.string   "detention_stable_departure"
    t.string   "detention_in_out"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "incoming_power"
  end

  create_table "rake_unloads_rake_commodities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "rake_unload_id"
    t.integer  "rake_commodity_id"
    t.integer  "rake_unit"
    t.float    "commodity_rake_count", limit: 24
    t.float    "net_tons",             limit: 24
    t.float    "freight",              limit: 24
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "short_routes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "from_station"
    t.string   "to_station"
    t.float    "short_route_distance",    limit: 24
    t.string   "short_interchange_point"
    t.float    "other_route_distance",    limit: 24
    t.string   "other_interchange_point"
    t.string   "description"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "states", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "station_data_infrastructures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "station_under_ti_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "station_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "code"
    t.string   "inward_outward"
    t.string   "gaug"
    t.string   "section"
    t.integer  "area_id"
    t.string   "phsg_flag"
    t.string   "dpnd_flag"
    t.string   "srvg_sttn"
    t.string   "old_srvg_sttn"
    t.string   "dfrd_flag"
    t.string   "desc"
    t.string   "status"
    t.integer  "numeric_code"
    t.integer  "division_id"
    t.integer  "railway_zone_id"
    t.integer  "state_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "user_roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.boolean  "is_viewable",                      default: true
    t.boolean  "is_admin",                         default: false
    t.boolean  "is_superadmin",                    default: false
    t.boolean  "is_subadmin",                      default: false
    t.boolean  "rake_load_access",                 default: false
    t.boolean  "one_rake_load_access",             default: false
    t.boolean  "two_rake_load_access",             default: false
    t.boolean  "other_load_access",                default: false
    t.boolean  "rake_unload_access",               default: false
    t.boolean  "one_rake_unload_access",           default: false
    t.boolean  "aecs_unload_access",               default: false
    t.boolean  "gets_unload_access",               default: false
    t.boolean  "unusual_occurrence_report_access", default: false
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.boolean  "is_statistics_access"
    t.boolean  "is_dak_access"
    t.boolean  "is_block__access"
    t.boolean  "is_allowance_access"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "mobile_no"
    t.boolean  "admin",                  default: false
    t.string   "area"
    t.string   "role"
    t.string   "user_code"
    t.integer  "division_id"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "user_under"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "versions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string   "item_type",  limit: 191,        null: false
    t.integer  "item_id",                       null: false
    t.string   "event",                         null: false
    t.string   "whodunnit"
    t.text     "object",     limit: 4294967295
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree
  end

  create_table "wagon_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "group_rake_type"
    t.string   "rake_type"
    t.string   "stock_type_code"
    t.string   "wagon_type_code"
    t.string   "wagon_type_desc"
    t.string   "wagon_details_brake_type"
    t.string   "wagon_details_covered_open"
    t.string   "wagon_details_min_max_tare"
    t.string   "allowed_cmdt"
    t.integer  "load_class_wagon"
    t.integer  "load_class_train"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "is_viewable"
  end

end
