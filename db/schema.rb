# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20121024214611) do

  create_table "add_requst_id_to_cars", :force => true do |t|
    t.integer  "request_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "add_requst_id_to_cars", ["request_id"], :name => "index_add_requst_id_to_cars_on_request_id"

  create_table "admin_spare_infos", :force => true do |t|
    t.string   "catalog_number"
    t.string   "manufacturer"
    t.text     "content"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "attachments", :force => true do |t|
    t.integer  "email_id"
    t.string   "attachment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "attachments", ["email_id"], :name => "index_attachments_on_email_id"

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
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "request_id"
    t.boolean  "visible",        :default => true
  end

  add_index "cars", ["user_id"], :name => "index_cars_on_user_id"

  create_table "carts", :force => true do |t|
    t.string   "catalog_number"
    t.string   "manufacturer"
    t.integer  "quantity"
    t.integer  "probability"
    t.integer  "min_days"
    t.integer  "max_days"
    t.integer  "user_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "quantity_available"
    t.integer  "order_id"
  end

  add_index "carts", ["user_id"], :name => "index_carts_on_user_id"

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
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.boolean  "visible",                     :default => true
  end

  add_index "email_addresses", ["user_id"], :name => "index_email_addresses_on_user_id"

  create_table "emails", :force => true do |t|
    t.text     "from_addrs"
    t.text     "return_path"
    t.text     "from"
    t.text     "subject"
    t.text     "in_reply_to"
    t.text     "to_addrs"
    t.text     "html_part",        :limit => 2147483647
    t.text     "text_part",        :limit => 2147483647
    t.text     "user_id"
    t.text     "to"
    t.text     "body",             :limit => 2147483647
    t.text     "cc_addrs"
    t.text     "bcc_addrs"
    t.text     "bcc"
    t.text     "cc"
    t.text     "resent_bcc"
    t.text     "resent_cc"
    t.text     "is_multipart"
    t.text     "parts_length"
    t.text     "date"
    t.text     "message_id"
    t.text     "name"
    t.text     "content_types"
    t.text     "classes"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "email_address_id"
  end

  create_table "names", :force => true do |t|
    t.string   "name"
    t.string   "creation_reason"
    t.string   "invisible"
    t.integer  "user_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.boolean  "visible",         :default => true
  end

  create_table "orders", :force => true do |t|
    t.integer  "name_id"
    t.integer  "postal_address_id"
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
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
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.boolean  "visible",                     :default => true
  end

  add_index "phones", ["user_id"], :name => "index_phones_on_user_id"

  create_table "pings", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "pings", ["user_id"], :name => "index_pings_on_user_id"

  create_table "plutus_accounts", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.boolean  "contra"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "plutus_accounts", ["name", "type"], :name => "index_plutus_accounts_on_name_and_type"

  create_table "plutus_amounts", :force => true do |t|
    t.string  "type"
    t.integer "account_id"
    t.integer "transaction_id"
    t.decimal "amount",         :precision => 20, :scale => 10
  end

  add_index "plutus_amounts", ["account_id", "transaction_id"], :name => "index_plutus_amounts_on_account_id_and_transaction_id"
  add_index "plutus_amounts", ["transaction_id", "account_id"], :name => "index_plutus_amounts_on_transaction_id_and_account_id"
  add_index "plutus_amounts", ["type"], :name => "index_plutus_amounts_on_type"

  create_table "plutus_transactions", :force => true do |t|
    t.string   "description"
    t.integer  "commercial_document_id"
    t.string   "commercial_document_type"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "plutus_transactions", ["commercial_document_id", "commercial_document_type"], :name => "index_transactions_on_commercial_doc"

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
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.boolean  "visible",    :default => true
  end

  add_index "postal_addresses", ["user_id"], :name => "index_postal_addresses_on_user_id"

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "products", :force => true do |t|
    t.string   "catalog_number"
    t.string   "manufacturer"
    t.integer  "quantity_ordered"
    t.integer  "quantity_available"
    t.integer  "probability"
    t.integer  "min_days"
    t.integer  "max_days"
    t.integer  "user_id"
    t.integer  "order_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "status"
    t.integer  "cost"
  end

  add_index "products", ["order_id"], :name => "index_products_on_order_id"
  add_index "products", ["user_id"], :name => "index_products_on_user_id"

  create_table "requests", :force => true do |t|
    t.integer  "user_id"
    t.integer  "car_id"
    t.string   "catalog_number"
    t.string   "manufacturer"
    t.text     "notes"
    t.string   "invisible"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "parent_request"
    t.string   "type"
    t.integer  "request_id"
    t.string   "creation_reason"
    t.string   "check_needed"
    t.string   "name"
    t.boolean  "visible",         :default => true
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
