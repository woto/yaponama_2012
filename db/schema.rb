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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130415060158) do

  create_table "accounts", force: true do |t|
    t.integer  "creator_id"
    t.decimal  "debit",            precision: 8, scale: 2, default: 0.0
    t.decimal  "credit",           precision: 8, scale: 2, default: 0.0
    t.integer  "accountable_id"
    t.string   "accountable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "add_requst_id_to_cars", force: true do |t|
    t.integer  "request_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "add_requst_id_to_cars", ["request_id"], name: "index_add_requst_id_to_cars_on_request_id"

  create_table "admin_blocks", force: true do |t|
    t.text     "content"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_site_settings", force: true do |t|
    t.string   "environment"
    t.string   "sms_notify_method"
    t.boolean  "send_request_from_search_page"
    t.integer  "price_request_cache_with_replacements_in_seconds"
    t.integer  "price_request_cache_without_replacements_in_seconds"
    t.boolean  "request_emex"
    t.float    "emex_income_rate"
    t.float    "avtorif_income_rate"
    t.float    "retail_rate"
    t.string   "robokassa_integration_mode"
    t.string   "robokassa_pass_1"
    t.string   "robokassa_pass_2"
    t.string   "robokassa_user"
    t.string   "checkout_account"
    t.string   "checkout_bank"
    t.string   "checkout_bik"
    t.string   "checkout_correspondent"
    t.string   "checkout_inn"
    t.string   "checkout_recipient"
    t.text     "counter_yandex"
    t.text     "counter_mail"
    t.text     "counter_rambler"
    t.text     "counter_google"
    t.text     "counter_openstat"
    t.text     "counter_liveinternet"
    t.float    "default_user_prepayment_percent"
    t.float    "default_user_discount"
    t.string   "default_user_order_rule"
    t.string   "avisosms_username"
    t.string   "avisosms_password"
    t.string   "avisosms_source_address"
    t.string   "avisosms_delivery_report"
    t.string   "avisosms_flash_message"
    t.string   "avisosms_validity_period"
    t.string   "site_address"
    t.string   "site_port"
    t.string   "redis_address"
    t.string   "redis_port"
    t.string   "socket_io_address"
    t.string   "socket_io_port"
    t.string   "juggernaut_address"
    t.string   "juggernaut_port"
    t.string   "price_address"
    t.string   "price_port"
    t.string   "get_image_data_address"
    t.string   "get_image_data_port"
    t.string   "google_oauth2_key"
    t.string   "google_oauth2_secret"
    t.string   "facebook_key"
    t.string   "facebook_secret"
    t.string   "yandex_key"
    t.string   "yandex_secret"
    t.string   "twitter_key"
    t.string   "twitter_secret"
    t.string   "vkontakte_key"
    t.string   "vkontakte_secret"
    t.string   "odnoklassniki_key"
    t.string   "odnoklassniki_secret"
    t.string   "mailru_key"
    t.string   "mailru_secret"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attachments", force: true do |t|
    t.integer  "email_id"
    t.string   "attachment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachments", ["email_id"], name: "index_attachments_on_email_id"

  create_table "auths", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "auths", ["user_id"], name: "index_auths_on_user_id"

  create_table "brands", force: true do |t|
    t.string   "name"
    t.integer  "brand_id"
    t.string   "image"
    t.integer  "rating"
    t.text     "content"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "calls", force: true do |t|
    t.integer  "phone_id"
    t.string   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "calls", ["phone_id"], name: "index_calls_on_phone_id"

  create_table "cars", force: true do |t|
    t.integer  "god"
    t.string   "period"
    t.string   "brand"
    t.string   "model"
    t.string   "generation"
    t.string   "modification"
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
    t.integer  "dverey"
    t.string   "rul"
    t.boolean  "selling"
    t.integer  "cost"
    t.boolean  "torg"
    t.text     "advertisement"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "car_number"
    t.string   "creation_reason"
    t.text     "notes"
    t.text     "notes_invisible"
    t.boolean  "removed"
    t.integer  "user_id"
    t.integer  "creator_id"
  end

  add_index "cars", ["creator_id"], name: "index_cars_on_creator_id"
  add_index "cars", ["user_id"], name: "index_cars_on_user_id"

  create_table "comments", force: true do |t|
    t.integer  "creator_id"
    t.text     "content"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ancestry"
  end

  add_index "comments", ["ancestry"], name: "index_comments_on_ancestry"

  create_table "companies", force: true do |t|
    t.string   "ownership"
    t.string   "name"
    t.string   "inn"
    t.string   "kpp"
    t.string   "ogrn"
    t.string   "account"
    t.string   "bank"
    t.string   "bik"
    t.string   "correspondent"
    t.string   "okpo"
    t.string   "okved"
    t.string   "okato"
    t.integer  "legal_address_id"
    t.integer  "actual_address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "creation_reason"
    t.text     "notes"
    t.text     "notes_invisible"
    t.boolean  "removed"
    t.integer  "user_id"
    t.integer  "creator_id"
  end

  add_index "companies", ["creator_id"], name: "index_companies_on_creator_id"
  add_index "companies", ["user_id"], name: "index_companies_on_user_id"

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0
    t.integer  "attempts",   default: 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "deliveries", force: true do |t|
    t.string   "name"
    t.text     "notes"
    t.text     "notes_invisible"
    t.boolean  "available"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "delivery_categories", force: true do |t|
    t.string   "name"
    t.text     "notes"
    t.text     "notes_invisible"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
  end

  create_table "email_addresses", force: true do |t|
    t.string   "email_address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "confirmed_by_user"
    t.boolean  "confirmed_by_manager"
    t.datetime "user_confirmation_datetime"
    t.datetime "manager_confirmation_datetime"
    t.string   "confirmation_token"
    t.string   "creation_reason"
    t.text     "notes"
    t.text     "notes_invisible"
    t.boolean  "removed"
    t.integer  "user_id"
    t.integer  "creator_id"
  end

  add_index "email_addresses", ["creator_id"], name: "index_email_addresses_on_creator_id"
  add_index "email_addresses", ["user_id"], name: "index_email_addresses_on_user_id"

  create_table "emails", force: true do |t|
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
    t.binary   "body"
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "email_address_id"
  end

  create_table "generations", force: true do |t|
    t.string   "name"
    t.integer  "model_id"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "metro", force: true do |t|
    t.string   "metro"
    t.integer  "delivery_cost"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "models", force: true do |t|
    t.integer  "brand_id"
    t.string   "name"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "modifications", force: true do |t|
    t.string   "name"
    t.integer  "generation_id"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "money_transactions", force: true do |t|
    t.integer  "account_id"
    t.integer  "product_transaction_id"
    t.decimal  "credit",                 precision: 8, scale: 2
    t.decimal  "debit",                  precision: 8, scale: 2
    t.string   "credit_log"
    t.string   "debit_log"
    t.text     "notes"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "names", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "creation_reason"
    t.text     "notes"
    t.text     "notes_invisible"
    t.boolean  "removed"
    t.integer  "user_id"
    t.integer  "creator_id"
  end

  add_index "names", ["creator_id"], name: "index_names_on_creator_id"
  add_index "names", ["user_id"], name: "index_names_on_user_id"

  create_table "orders", force: true do |t|
    t.integer  "name_id"
    t.integer  "postal_address_id"
    t.integer  "metro_id"
    t.integer  "user_id"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.decimal  "delivery_cost",     precision: 8, scale: 2
    t.integer  "delivery_id"
    t.string   "active"
    t.integer  "phone_id"
    t.text     "notes"
    t.text     "notes_invisible"
  end

  create_table "pages", force: true do |t|
    t.string   "path"
    t.text     "content"
    t.text     "keywords"
    t.text     "description"
    t.string   "title"
    t.string   "robots"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages_uploads", id: false, force: true do |t|
    t.integer "page_id"
    t.integer "upload_id"
  end

  create_table "phones", force: true do |t|
    t.string   "phone"
    t.string   "phone_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "confirmed_by_user"
    t.boolean  "confirmed_by_manager"
    t.datetime "user_confirmation_datetime"
    t.datetime "manager_confirmation_datetime"
    t.string   "confirmation_token"
    t.string   "creation_reason"
    t.text     "notes"
    t.text     "notes_invisible"
    t.boolean  "removed"
    t.integer  "user_id"
    t.integer  "creator_id"
  end

  add_index "phones", ["creator_id"], name: "index_phones_on_creator_id"
  add_index "phones", ["user_id"], name: "index_phones_on_user_id"

  create_table "postal_addresses", force: true do |t|
    t.string   "company"
    t.string   "postcode"
    t.string   "region"
    t.string   "city"
    t.string   "street"
    t.string   "house"
    t.string   "room"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "creation_reason"
    t.text     "notes"
    t.text     "notes_invisible"
    t.boolean  "removed"
    t.integer  "user_id"
    t.integer  "creator_id"
  end

  add_index "postal_addresses", ["creator_id"], name: "index_postal_addresses_on_creator_id"
  add_index "postal_addresses", ["user_id"], name: "index_postal_addresses_on_user_id"

  create_table "product_transactions", force: true do |t|
    t.string   "log_catalog_number"
    t.boolean  "log_hide_catalog_number"
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
    t.decimal  "log_buy_cost",            precision: 8, scale: 2
    t.decimal  "log_sell_cost",           precision: 8, scale: 2
    t.string   "log_short_name"
    t.text     "log_long_name"
    t.integer  "log_product_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "catalog_number"
    t.boolean  "hide_catalog_number"
    t.string   "manufacturer"
    t.string   "status"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "supplier_id"
    t.integer  "quantity_ordered"
    t.integer  "quantity_available"
    t.integer  "probability"
    t.integer  "min_days"
    t.integer  "max_days"
    t.decimal  "buy_cost",            precision: 8, scale: 2
    t.decimal  "sell_cost",           precision: 8, scale: 2
    t.string   "short_name"
    t.text     "long_name"
    t.integer  "product_id"
    t.string   "creation_reason"
    t.text     "notes"
    t.text     "notes_invisible"
    t.boolean  "removed"
    t.integer  "user_id"
    t.integer  "creator_id"
  end

  add_index "products", ["creator_id"], name: "index_products_on_creator_id"
  add_index "products", ["order_id"], name: "index_products_on_order_id"
  add_index "products", ["user_id"], name: "index_products_on_user_id"

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

  create_table "spare_infos", force: true do |t|
    t.string   "catalog_number"
    t.string   "manufacturer"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stats", force: true do |t|
    t.string   "location"
    t.string   "title"
    t.string   "referrer"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stats", ["user_id"], name: "index_stats_on_user_id"

  create_table "suppliers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "talks", force: true do |t|
    t.integer  "talkable_id"
    t.string   "talkable_type"
    t.integer  "user_id"
    t.integer  "creator_id"
    t.boolean  "read"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "talks", ["creator_id"], name: "index_talks_on_creator_id"
  add_index "talks", ["talkable_id", "talkable_type"], name: "index_talks_on_talkable_id_and_talkable_type"
  add_index "talks", ["user_id"], name: "index_talks_on_user_id"

  create_table "uploads", force: true do |t|
    t.string   "upload"
    t.string   "content_type"
    t.integer  "file_size"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.integer  "creator_id"
    t.string   "creation_reason"
    t.decimal  "discount",                    precision: 8, scale: 2
    t.decimal  "prepayment_percent",          precision: 8, scale: 2
    t.string   "role"
    t.string   "auth_token"
    t.string   "password_digest"
    t.string   "password_reset_email_token"
    t.string   "password_reset_sms_token"
    t.datetime "password_reset_sent_at"
    t.string   "ipgeobase_city"
    t.string   "ipgeobase_country"
    t.string   "ipgeobase_region"
    t.string   "ipgeobase_district"
    t.float    "ipgeobase_lat"
    t.float    "ipgeobase_lng"
    t.string   "accept_language"
    t.string   "user_agent"
    t.integer  "russian_time_zone_auto_id"
    t.integer  "russian_time_zone_manual_id"
    t.inet     "remote_ip"
    t.text     "notes"
    t.text     "notes_invisible"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "order_rule"
  end

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"

end
