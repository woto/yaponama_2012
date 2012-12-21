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

ActiveRecord::Schema.define(:version => 20121219165349) do

  create_table "accounts", :force => true do |t|
    t.decimal  "debit",            :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "credit",           :precision => 8, :scale => 2, :default => 0.0
    t.integer  "accountable_id"
    t.string   "accountable_type"
    t.datetime "created_at",                                                      :null => false
    t.datetime "updated_at",                                                      :null => false
  end

  create_table "add_requst_id_to_cars", :force => true do |t|
    t.integer  "request_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "add_requst_id_to_cars", ["request_id"], :name => "index_add_requst_id_to_cars_on_request_id"

  create_table "admin_companies", :force => true do |t|
    t.string   "inn"
    t.string   "kpp"
    t.string   "name"
    t.string   "bank_account"
    t.string   "account"
    t.string   "correspondent_account"
    t.string   "bic"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

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
    t.text     "notes_invisible"
    t.integer  "user_id"
    t.integer  "creator_id"
    t.boolean  "visible"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "request_id"
    t.string   "car_number"
    t.text     "notes"
  end

  add_index "cars", ["user_id"], :name => "index_cars_on_user_id"

  create_table "deliveries", :force => true do |t|
    t.string   "name"
    t.text     "notes"
    t.boolean  "available"
    t.text     "notes_invisible"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.boolean  "name_required"
    t.boolean  "postal_address_required"
    t.boolean  "full_prepayment_required"
    t.boolean  "delivery_cost_required"
    t.boolean  "phone_required"
    t.boolean  "metro_required"
    t.integer  "sequence"
    t.integer  "delivery_category_id"
    t.string   "image"
  end

  create_table "delivery_categories", :force => true do |t|
    t.string   "name"
    t.text     "notes"
    t.text     "notes_invisible"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "image"
  end

  create_table "email_addresses", :force => true do |t|
    t.string   "email_address"
    t.boolean  "confirmed_by_robot"
    t.boolean  "confirmed_by_human"
    t.datetime "robot_confirmation_datetime"
    t.datetime "human_confirmation_datetime"
    t.text     "notes_invisible"
    t.integer  "user_id"
    t.integer  "creator_id"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.text     "notes"
  end

  add_index "email_addresses", ["user_id"], :name => "index_email_addresses_on_user_id"

  create_table "emails", :force => true do |t|
    t.text     "from_addrs"
    t.text     "return_path"
    t.text     "from"
    t.text     "subject"
    t.text     "in_reply_to"
    t.text     "to_addrs"
    t.text     "html_part"
    t.text     "text_part"
    t.text     "user_id"
    t.text     "to"
    t.text     "body"
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
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "email_address_id"
  end

  create_table "metro", :force => true do |t|
    t.string   "metro"
    t.integer  "delivery_cost"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "money_transactions", :force => true do |t|
    t.integer  "left_account_id"
    t.integer  "right_account_id"
    t.boolean  "left_real"
    t.boolean  "right_real"
    t.decimal  "left_money",        :precision => 8, :scale => 2
    t.decimal  "right_money",       :precision => 8, :scale => 2
    t.text     "notes"
    t.integer  "documentable_id"
    t.string   "documentable_type"
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
  end

  create_table "names", :force => true do |t|
    t.string   "name"
    t.string   "creation_reason"
    t.text     "notes_invisible"
    t.integer  "user_id"
    t.integer  "creator_id"
    t.boolean  "visible",         :default => true
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.text     "notes"
  end

  create_table "orders", :force => true do |t|
    t.integer  "name_id"
    t.integer  "postal_address_id"
    t.integer  "metro_id"
    t.integer  "user_id"
    t.integer  "creator_id"
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
    t.string   "status"
    t.decimal  "delivery_cost",     :precision => 8, :scale => 2
    t.integer  "delivery_id"
    t.string   "active"
    t.integer  "phone_id"
    t.text     "notes"
    t.text     "notes_invisible"
  end

  create_table "phones", :force => true do |t|
    t.string   "phone"
    t.text     "notes"
    t.boolean  "confirmed_by_robot"
    t.boolean  "confirmed_by_human"
    t.datetime "robot_confirmation_datetime"
    t.datetime "human_confirmation_datetime"
    t.string   "can_receive_sms"
    t.text     "notes_invisible"
    t.integer  "user_id"
    t.integer  "creator_id"
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
    t.text     "notes_invisible"
    t.integer  "user_id"
    t.integer  "creator_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "postal_addresses", ["user_id"], :name => "index_postal_addresses_on_user_id"

  create_table "product_transactions", :force => true do |t|
    t.string   "log_catalog_number"
    t.string   "log_manufacturer"
    t.string   "log_status"
    t.text     "log_notes"
    t.text     "log_notes_invisible"
    t.integer  "log_user_id"
    t.integer  "log_creator_id"
    t.integer  "log_order_id"
    t.datetime "log_created_at"
    t.datetime "log_updated_at"
    t.integer  "log_supplier_id"
    t.integer  "log_quantity_ordered"
    t.integer  "log_quantity_available"
    t.integer  "log_probability"
    t.integer  "log_min_days"
    t.integer  "log_max_days"
    t.decimal  "log_buy_cost",           :precision => 8, :scale => 2
    t.decimal  "log_sell_cost",          :precision => 8, :scale => 2
    t.string   "log_short_name"
    t.text     "log_long_name"
    t.integer  "log_product_id"
    t.integer  "product_id"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
  end

  create_table "products", :force => true do |t|
    t.string   "catalog_number"
    t.string   "manufacturer"
    t.string   "status"
    t.text     "notes",                                            :default => ""
    t.text     "notes_invisible",                                  :default => ""
    t.integer  "user_id"
    t.integer  "creator_id"
    t.integer  "order_id"
    t.datetime "created_at",                                                       :null => false
    t.datetime "updated_at",                                                       :null => false
    t.integer  "supplier_id"
    t.integer  "quantity_ordered"
    t.integer  "quantity_available"
    t.integer  "probability"
    t.integer  "min_days"
    t.integer  "max_days"
    t.decimal  "buy_cost",           :precision => 8, :scale => 2
    t.decimal  "sell_cost",          :precision => 8, :scale => 2
    t.string   "short_name",                                       :default => ""
    t.text     "long_name",                                        :default => ""
    t.integer  "product_id"
  end

  add_index "products", ["order_id"], :name => "index_products_on_order_id"
  add_index "products", ["user_id"], :name => "index_products_on_user_id"

  create_table "requests", :force => true do |t|
    t.integer  "car_id"
    t.string   "catalog_number"
    t.string   "manufacturer"
    t.text     "notes"
    t.text     "notes_invisible"
    t.integer  "user_id"
    t.integer  "creator_id"
    t.boolean  "visible",         :default => true
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "parent_request"
    t.string   "type"
    t.integer  "request_id"
    t.string   "creation_reason"
    t.string   "check_needed"
    t.string   "name"
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

  create_table "suppliers", :force => true do |t|
    t.string   "name"
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
    t.integer  "creator_id"
    t.string   "session_id"
    t.text     "notes_invisible"
    t.string   "creation_reason"
    t.decimal  "discount",               :precision => 8, :scale => 2
    t.decimal  "prepayment_percent",     :precision => 8, :scale => 2
    t.integer  "time_zone_id"
    t.integer  "ping_id"
    t.string   "role"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.string   "order_rule"
    t.text     "notes"
    t.string   "password_digest"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

end
