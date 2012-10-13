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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121013132020) do

  create_table "add_requst_id_to_cars", :force => true do |t|
    t.integer  "request_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "add_requst_id_to_cars", ["request_id"], :name => "index_add_requst_id_to_cars_on_request_id"

  create_table "cars", :force => true do |t|
    t.string   "god"
    t.string   "marka"
    t.string   "model"
    t.string   "dvigatel"
    t.string   "tip"
    t.string   "moschnost"
    t.string   "privod"
    t.string   "tip_kuzova"
    t.string   "kpp"
    t.string   "kod_kuzova"
    t.string   "kod_dvigatelya"
    t.string   "rinok"
    t.string   "vin"
    t.string   "frame"
    t.string   "komplektaciya"
    t.string   "invisible"
    t.integer  "user_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "request_id"
  end

  add_index "cars", ["user_id"], :name => "index_cars_on_user_id"

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "email_addresses", :force => true do |t|
    t.string   "email_address"
    t.boolean  "confirmed_by_robot"
    t.boolean  "confirmed_by_human"
    t.datetime "robot_confirmation_datetime"
    t.datetime "human_confirmation_datetime"
    t.string   "invisible"
    t.integer  "user_id"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "email_addresses", ["user_id"], :name => "index_email_addresses_on_user_id"

  create_table "emails", :force => true do |t|
    t.string   "from_addrs"
    t.string   "return_path"
    t.string   "from"
    t.string   "subject"
    t.string   "in_reply_to"
    t.string   "to_addrs"
    t.text     "html_part"
    t.text     "text_part"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "names", :force => true do |t|
    t.string   "name"
    t.string   "creation_reason"
    t.string   "invisible"
    t.integer  "user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "phones", :force => true do |t|
    t.string   "phone"
    t.string   "notes"
    t.boolean  "confirmed_by_robot"
    t.boolean  "confirmed_by_human"
    t.datetime "robot_confirmation_datetime"
    t.datetime "human_confirmation_datetime"
    t.boolean  "can_receive_sms"
    t.string   "invisible"
    t.integer  "user_id"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "phones", ["user_id"], :name => "index_phones_on_user_id"

  create_table "pings", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "pings", ["user_id"], :name => "index_pings_on_user_id"

  create_table "postal_addresses", :force => true do |t|
    t.string   "company"
    t.string   "postcode"
    t.string   "region"
    t.string   "city"
    t.string   "street"
    t.string   "house"
    t.string   "room"
    t.text     "notes"
    t.string   "invisible"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "postal_addresses", ["user_id"], :name => "index_postal_addresses_on_user_id"

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "requests", :force => true do |t|
    t.integer  "user_id"
    t.integer  "car_id"
    t.string   "catalog_number"
    t.string   "manufacturer"
    t.text     "notes"
    t.string   "invisible"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "parent_request"
    t.string   "type"
    t.integer  "request_id"
    t.string   "creation_reason"
    t.string   "check_needed"
    t.integer  "cost"
    t.integer  "days"
    t.integer  "approx_cost"
    t.integer  "approx_days"
  end

  add_index "requests", ["car_id"], :name => "index_requests_on_car_id"
  add_index "requests", ["user_id"], :name => "index_requests_on_user_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "test_module_test_entities", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "time_zones", :force => true do |t|
    t.string   "time_zone"
    t.integer  "utc_offset_hours"
    t.integer  "utc_offset_minutes"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "session_id"
    t.string   "invisible"
    t.string   "creation_reason"
    t.integer  "time_zone_id"
    t.integer  "ping_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
