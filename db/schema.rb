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

ActiveRecord::Schema.define(version: 99999999999999) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "citext"
  enable_extension "hstore"

  create_table "account_transactions", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "creator_id"
    t.integer  "product_transaction_id"
    t.text     "comment"
    t.decimal  "debit_before"
    t.decimal  "debit_after"
    t.decimal  "credit_before"
    t.decimal  "credit_after"
    t.integer  "somebody_id_before"
    t.integer  "somebody_id_after"
    t.datetime "created_at"
  end

  add_index "account_transactions", ["account_id"], name: "index_account_transactions_on_account_id", using: :btree
  add_index "account_transactions", ["creator_id"], name: "index_account_transactions_on_creator_id", using: :btree
  add_index "account_transactions", ["product_transaction_id"], name: "index_account_transactions_on_product_transaction_id", using: :btree

  create_table "accounts", force: :cascade do |t|
    t.decimal  "debit",       precision: 8, scale: 2, default: 0.0
    t.decimal  "credit",      precision: 8, scale: 2, default: 0.0
    t.integer  "somebody_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts", ["somebody_id"], name: "index_accounts_on_somebody_id", using: :btree

  create_table "admin_site_settings", force: :cascade do |t|
    t.string   "from_email_address",                                  limit: 255
    t.string   "environment",                                         limit: 255
    t.string   "sms_notify_method",                                   limit: 255
    t.boolean  "send_request_from_search_page"
    t.integer  "price_request_cache_with_replacements_in_seconds"
    t.integer  "price_request_cache_without_replacements_in_seconds"
    t.boolean  "request_emex"
    t.float    "emex_income_rate"
    t.float    "avtorif_income_rate"
    t.float    "retail_rate"
    t.string   "robokassa_integration_mode",                          limit: 255
    t.string   "robokassa_pass_1",                                    limit: 255
    t.string   "robokassa_pass_2",                                    limit: 255
    t.string   "robokassa_user",                                      limit: 255
    t.string   "google_maps_key",                                     limit: 255
    t.string   "travel_mode",                                         limit: 255
    t.float    "initial_map_lat"
    t.float    "initial_map_lng"
    t.integer  "initial_map_zoom"
    t.float    "delivery_minute_cost"
    t.string   "warehouse_address",                                   limit: 255
    t.boolean  "automatic_calculate_active"
    t.float    "max_automatic_calculated_cost"
    t.string   "checkout_account",                                    limit: 255
    t.string   "checkout_bank",                                       limit: 255
    t.string   "checkout_bik",                                        limit: 255
    t.string   "checkout_correspondent",                              limit: 255
    t.string   "checkout_inn",                                        limit: 255
    t.string   "checkout_recipient",                                  limit: 255
    t.text     "counter_yandex"
    t.text     "counter_mail"
    t.text     "counter_rambler"
    t.text     "counter_google"
    t.text     "counter_openstat"
    t.text     "counter_liveinternet"
    t.float    "default_somebody_prepayment"
    t.float    "default_somebody_discount"
    t.string   "default_somebody_order_rule",                         limit: 255
    t.string   "avisosms_username",                                   limit: 255
    t.string   "avisosms_password",                                   limit: 255
    t.string   "avisosms_source_address",                             limit: 255
    t.string   "avisosms_delivery_report",                            limit: 255
    t.string   "avisosms_flash_message",                              limit: 255
    t.string   "avisosms_validity_period",                            limit: 255
    t.string   "avisosms_email_address",                              limit: 255
    t.string   "site_address",                                        limit: 255
    t.string   "site_port",                                           limit: 255
    t.string   "redis_address",                                       limit: 255
    t.string   "redis_port",                                          limit: 255
    t.string   "realtime_address",                                    limit: 255
    t.string   "realtime_port",                                       limit: 255
    t.string   "juggernaut_address",                                  limit: 255
    t.string   "juggernaut_port",                                     limit: 255
    t.string   "price_address",                                       limit: 255
    t.string   "price_port",                                          limit: 255
    t.string   "get_image_data_address",                              limit: 255
    t.string   "get_image_data_port",                                 limit: 255
    t.string   "google_oauth2_key",                                   limit: 255
    t.string   "google_oauth2_secret",                                limit: 255
    t.string   "facebook_key",                                        limit: 255
    t.string   "facebook_secret",                                     limit: 255
    t.string   "yandex_key",                                          limit: 255
    t.string   "yandex_secret",                                       limit: 255
    t.string   "twitter_key",                                         limit: 255
    t.string   "twitter_secret",                                      limit: 255
    t.string   "vkontakte_key",                                       limit: 255
    t.string   "vkontakte_secret",                                    limit: 255
    t.string   "odnoklassniki_key",                                   limit: 255
    t.string   "odnoklassniki_secret",                                limit: 255
    t.string   "mailru_key",                                          limit: 255
    t.string   "mailru_secret",                                       limit: 255
    t.string   "default_time_zone_id",                                limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mail_delivery_method",                                limit: 255
    t.string   "smtp_address",                                        limit: 255
    t.integer  "smtp_port"
    t.string   "smtp_user_name",                                      limit: 255
    t.string   "smtp_password",                                       limit: 255
    t.string   "smtp_authentication",                                 limit: 255
    t.boolean  "smtp_enable_starttls_auto"
  end

  create_table "auths", force: :cascade do |t|
    t.string   "provider",    limit: 255
    t.string   "uid",         limit: 255
    t.integer  "somebody_id"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "auths", ["somebody_id"], name: "index_auths_on_somebody_id", using: :btree

  create_table "block_transactions", force: :cascade do |t|
    t.integer  "block_id"
    t.string   "operation",      limit: 255
    t.integer  "creator_id"
    t.string   "name_before",    limit: 255
    t.string   "name_after",     limit: 255
    t.text     "content_before"
    t.text     "content_after"
    t.datetime "created_at"
  end

  add_index "block_transactions", ["block_id"], name: "index_block_transactions_on_block_id", using: :btree
  add_index "block_transactions", ["creator_id"], name: "index_block_transactions_on_creator_id", using: :btree

  create_table "blocks", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bots", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "comment",    limit: 255
    t.string   "user_agent", limit: 255
    t.inet     "inet"
    t.boolean  "phantom"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "block",                  default: false
  end

  create_table "brand_transactions", force: :cascade do |t|
    t.integer  "brand_id"
    t.string   "operation",              limit: 255
    t.integer  "creator_id"
    t.string   "name_before",            limit: 255
    t.string   "name_after",             limit: 255
    t.string   "path_before",            limit: 255
    t.string   "path_after",             limit: 255
    t.integer  "brand_id_before"
    t.integer  "brand_id_after"
    t.string   "cached_brand_before",    limit: 255
    t.string   "cached_brand_after",     limit: 255
    t.string   "image_before",           limit: 255
    t.string   "image_after",            limit: 255
    t.integer  "rating_before"
    t.integer  "rating_after"
    t.text     "content_before"
    t.text     "content_after"
    t.boolean  "phantom_before"
    t.boolean  "phantom_after"
    t.boolean  "catalog_before"
    t.boolean  "catalog_after"
    t.boolean  "is_brand_before"
    t.boolean  "is_brand_after"
    t.datetime "created_at"
    t.boolean  "manufacturer_before"
    t.boolean  "manufacturer_after"
    t.text     "preview_before"
    t.text     "preview_after"
    t.string   "slang_before",           limit: 255
    t.string   "slang_after",            limit: 255
    t.boolean  "default_display_before"
    t.boolean  "default_display_after"
  end

  add_index "brand_transactions", ["brand_id"], name: "index_brand_transactions_on_brand_id", using: :btree
  add_index "brand_transactions", ["creator_id"], name: "index_brand_transactions_on_creator_id", using: :btree

  create_table "brands", force: :cascade do |t|
    t.citext   "name"
    t.integer  "brand_id"
    t.string   "cached_brand",    limit: 255
    t.string   "image",           limit: 255
    t.integer  "rating"
    t.text     "content"
    t.integer  "creator_id"
    t.boolean  "phantom"
    t.boolean  "is_brand"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "preview"
    t.string   "slang",           limit: 255
    t.boolean  "default_display"
    t.string   "opts",                        default: [], array: true
  end

  add_index "brands", ["brand_id"], name: "index_brands_on_brand_id", using: :btree
  add_index "brands", ["creator_id"], name: "index_brands_on_creator_id", using: :btree

  create_table "callbacks", force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.integer  "somebody_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "callbacks", ["somebody_id"], name: "index_callbacks_on_somebody_id", using: :btree

  create_table "calls", force: :cascade do |t|
    t.integer  "phone_id"
    t.integer  "somebody_id"
    t.string   "file",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "calls", ["phone_id"], name: "index_calls_on_phone_id", using: :btree
  add_index "calls", ["somebody_id"], name: "index_calls_on_somebody_id", using: :btree

  create_table "car_transactions", force: :cascade do |t|
    t.integer  "car_id"
    t.string   "operation",                  limit: 255
    t.integer  "creator_id"
    t.integer  "god_before"
    t.integer  "god_after"
    t.string   "period_before",              limit: 255
    t.string   "period_after",               limit: 255
    t.integer  "brand_id_before"
    t.integer  "brand_id_after"
    t.string   "cached_brand_before",        limit: 255
    t.string   "cached_brand_after",         limit: 255
    t.integer  "model_id_before"
    t.integer  "model_id_after"
    t.string   "cached_model_before",        limit: 255
    t.string   "cached_model_after",         limit: 255
    t.integer  "generation_id_before"
    t.integer  "generation_id_after"
    t.string   "cached_generation_before",   limit: 255
    t.string   "cached_generation_after",    limit: 255
    t.integer  "modification_id_before"
    t.integer  "modification_id_after"
    t.string   "cached_modification_before", limit: 255
    t.string   "cached_modification_after",  limit: 255
    t.string   "dvigatel_before",            limit: 255
    t.string   "dvigatel_after",             limit: 255
    t.string   "tip_before",                 limit: 255
    t.string   "tip_after",                  limit: 255
    t.string   "moschnost_before",           limit: 255
    t.string   "moschnost_after",            limit: 255
    t.string   "privod_before",              limit: 255
    t.string   "privod_after",               limit: 255
    t.string   "tip_kuzova_before",          limit: 255
    t.string   "tip_kuzova_after",           limit: 255
    t.string   "kpp_before",                 limit: 255
    t.string   "kpp_after",                  limit: 255
    t.string   "kod_kuzova_before",          limit: 255
    t.string   "kod_kuzova_after",           limit: 255
    t.string   "kod_dvigatelya_before",      limit: 255
    t.string   "kod_dvigatelya_after",       limit: 255
    t.string   "rinok_before",               limit: 255
    t.string   "rinok_after",                limit: 255
    t.string   "vin_before",                 limit: 255
    t.string   "vin_after",                  limit: 255
    t.string   "frame_before",               limit: 255
    t.string   "frame_after",                limit: 255
    t.string   "vin_or_frame_before",        limit: 255
    t.string   "vin_or_frame_after",         limit: 255
    t.string   "komplektaciya_before",       limit: 255
    t.string   "komplektaciya_after",        limit: 255
    t.integer  "dverey_before"
    t.integer  "dverey_after"
    t.string   "rul_before",                 limit: 255
    t.string   "rul_after",                  limit: 255
    t.string   "car_number_before",          limit: 255
    t.string   "car_number_after",           limit: 255
    t.string   "creation_reason_before",     limit: 255
    t.string   "creation_reason_after",      limit: 255
    t.text     "notes_before"
    t.text     "notes_after"
    t.text     "notes_invisible_before"
    t.text     "notes_invisible_after"
    t.integer  "somebody_id_before"
    t.integer  "somebody_id_after"
    t.datetime "created_at"
  end

  add_index "car_transactions", ["car_id"], name: "index_car_transactions_on_car_id", using: :btree
  add_index "car_transactions", ["creator_id"], name: "index_car_transactions_on_creator_id", using: :btree

  create_table "cars", force: :cascade do |t|
    t.integer  "god"
    t.string   "period",              limit: 255
    t.integer  "brand_id"
    t.string   "cached_brand",        limit: 255
    t.integer  "model_id"
    t.string   "cached_model",        limit: 255
    t.integer  "generation_id"
    t.string   "cached_generation",   limit: 255
    t.integer  "modification_id"
    t.string   "cached_modification", limit: 255
    t.string   "dvigatel",            limit: 255
    t.string   "tip",                 limit: 255
    t.string   "moschnost",           limit: 255
    t.string   "privod",              limit: 255
    t.string   "tip_kuzova",          limit: 255
    t.string   "kpp",                 limit: 255
    t.string   "kod_kuzova",          limit: 255
    t.string   "kod_dvigatelya",      limit: 255
    t.string   "rinok",               limit: 255
    t.string   "vin",                 limit: 255
    t.string   "frame",               limit: 255
    t.string   "vin_or_frame",        limit: 255
    t.string   "komplektaciya",       limit: 255
    t.integer  "dverey"
    t.string   "rul",                 limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "car_number",          limit: 255
    t.string   "creation_reason",     limit: 255
    t.text     "notes",                           default: ""
    t.text     "notes_invisible",                 default: ""
    t.integer  "somebody_id"
    t.integer  "creator_id"
  end

  add_index "cars", ["brand_id"], name: "index_cars_on_brand_id", using: :btree
  add_index "cars", ["creator_id"], name: "index_cars_on_creator_id", using: :btree
  add_index "cars", ["generation_id"], name: "index_cars_on_generation_id", using: :btree
  add_index "cars", ["model_id"], name: "index_cars_on_model_id", using: :btree
  add_index "cars", ["modification_id"], name: "index_cars_on_modification_id", using: :btree
  add_index "cars", ["somebody_id"], name: "index_cars_on_somebody_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "creator_id"
    t.text     "content"
    t.integer  "commentable_id"
    t.string   "commentable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ancestry",         limit: 255
  end

  add_index "comments", ["ancestry"], name: "index_comments_on_ancestry", using: :btree

  create_table "companies", force: :cascade do |t|
    t.string   "ownership",             limit: 255
    t.string   "name",                  limit: 255
    t.string   "inn",                   limit: 255
    t.string   "kpp",                   limit: 255
    t.string   "ogrn",                  limit: 255
    t.string   "account",               limit: 255
    t.string   "bank",                  limit: 255
    t.string   "bik",                   limit: 255
    t.string   "correspondent",         limit: 255
    t.string   "okpo",                  limit: 255
    t.string   "okved",                 limit: 255
    t.string   "okato",                 limit: 255
    t.integer  "legal_address_id"
    t.string   "cached_legal_address",  limit: 255
    t.integer  "actual_address_id"
    t.string   "cached_actual_address", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "creation_reason",       limit: 255
    t.text     "notes",                             default: ""
    t.text     "notes_invisible",                   default: ""
    t.integer  "somebody_id"
    t.integer  "creator_id"
  end

  add_index "companies", ["actual_address_id"], name: "index_companies_on_actual_address_id", using: :btree
  add_index "companies", ["creator_id"], name: "index_companies_on_creator_id", using: :btree
  add_index "companies", ["legal_address_id"], name: "index_companies_on_legal_address_id", using: :btree
  add_index "companies", ["somebody_id"], name: "index_companies_on_somebody_id", using: :btree

  create_table "company_transactions", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "operation",                    limit: 255
    t.integer  "creator_id"
    t.string   "ownership_before",             limit: 255
    t.string   "ownership_after",              limit: 255
    t.string   "name_before",                  limit: 255
    t.string   "name_after",                   limit: 255
    t.string   "inn_before",                   limit: 255
    t.string   "inn_after",                    limit: 255
    t.string   "kpp_before",                   limit: 255
    t.string   "kpp_after",                    limit: 255
    t.string   "ogrn_before",                  limit: 255
    t.string   "ogrn_after",                   limit: 255
    t.string   "account_before",               limit: 255
    t.string   "account_after",                limit: 255
    t.string   "bank_before",                  limit: 255
    t.string   "bank_after",                   limit: 255
    t.string   "bik_before",                   limit: 255
    t.string   "bik_after",                    limit: 255
    t.string   "correspondent_before",         limit: 255
    t.string   "correspondent_after",          limit: 255
    t.string   "okpo_before",                  limit: 255
    t.string   "okpo_after",                   limit: 255
    t.string   "okved_before",                 limit: 255
    t.string   "okved_after",                  limit: 255
    t.string   "okato_before",                 limit: 255
    t.string   "okato_after",                  limit: 255
    t.integer  "legal_address_id_before"
    t.integer  "legal_address_id_after"
    t.string   "cached_legal_address_before",  limit: 255
    t.string   "cached_legal_address_after",   limit: 255
    t.integer  "actual_address_id_before"
    t.integer  "actual_address_id_after"
    t.string   "cached_actual_address_before", limit: 255
    t.string   "cached_actual_address_after",  limit: 255
    t.string   "creation_reason_before",       limit: 255
    t.string   "creation_reason_after",        limit: 255
    t.text     "notes_before"
    t.text     "notes_after"
    t.text     "notes_invisible_before"
    t.text     "notes_invisible_after"
    t.integer  "somebody_id_before"
    t.integer  "somebody_id_after"
    t.datetime "created_at"
  end

  add_index "company_transactions", ["company_id"], name: "index_company_transactions_on_company_id", using: :btree
  add_index "company_transactions", ["creator_id"], name: "index_company_transactions_on_creator_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",               default: 0
    t.integer  "attempts",               default: 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "deliveries_options", force: :cascade do |t|
    t.string   "name",                     limit: 255
    t.boolean  "full_prepayment_required"
    t.boolean  "postal_address_required"
    t.boolean  "passport_required"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deliveries_places", force: :cascade do |t|
    t.string   "name",                    limit: 255
    t.text     "content"
    t.text     "vertices"
    t.string   "active_fill_color",       limit: 255
    t.string   "active_fill_opacity",     limit: 255
    t.string   "active_stroke_color",     limit: 255
    t.string   "active_stroke_opacity",   limit: 255
    t.string   "active_stroke_weight",    limit: 255
    t.string   "inactive_fill_color",     limit: 255
    t.string   "inactive_fill_opacity",   limit: 255
    t.string   "inactive_stroke_color",   limit: 255
    t.string   "inactive_stroke_opacity", limit: 255
    t.string   "inactive_stroke_weight",  limit: 255
    t.boolean  "realize",                             default: true
    t.boolean  "active",                              default: true
    t.float    "lat"
    t.float    "lng"
    t.integer  "zoom"
    t.integer  "z_index"
    t.boolean  "display_marker"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone1",                  limit: 255
    t.string   "phone2",                  limit: 255
    t.string   "phone3",                  limit: 255
    t.string   "phone4",                  limit: 255
    t.string   "phone5",                  limit: 255
    t.string   "postal_address",          limit: 255
    t.string   "image1",                  limit: 255
    t.string   "image2",                  limit: 255
    t.string   "image3",                  limit: 255
    t.string   "address_locality",        limit: 255
    t.string   "postal_code",             limit: 255
    t.string   "street_address",          limit: 255
    t.string   "email1",                  limit: 255
    t.string   "email2",                  limit: 255
    t.string   "email3",                  limit: 255
    t.string   "image4"
    t.string   "image5"
    t.string   "price_url"
    t.string   "metro"
  end

  create_table "deliveries_variants", force: :cascade do |t|
    t.integer  "place_id"
    t.integer  "option_id"
    t.boolean  "active"
    t.integer  "sequence"
    t.string   "name",          limit: 255
    t.float    "delivery_cost"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "email_transactions", force: :cascade do |t|
    t.integer  "email_id"
    t.string   "operation",                    limit: 255
    t.integer  "creator_id"
    t.string   "value_before",                 limit: 255
    t.string   "value_after",                  limit: 255
    t.integer  "profile_id_before"
    t.integer  "profile_id_after"
    t.boolean  "confirmed_before"
    t.boolean  "confirmed_after"
    t.datetime "confirmation_datetime_before"
    t.datetime "confirmation_datetime_after"
    t.string   "confirmation_token_before",    limit: 255
    t.string   "confirmation_token_after",     limit: 255
    t.string   "creation_reason_before",       limit: 255
    t.string   "creation_reason_after",        limit: 255
    t.text     "notes_before"
    t.text     "notes_after"
    t.text     "notes_invisible_before"
    t.text     "notes_invisible_after"
    t.integer  "somebody_id_before"
    t.integer  "somebody_id_after"
    t.datetime "created_at"
  end

  add_index "email_transactions", ["creator_id"], name: "index_email_transactions_on_creator_id", using: :btree
  add_index "email_transactions", ["email_id"], name: "index_email_transactions_on_email_id", using: :btree

  create_table "emails", force: :cascade do |t|
    t.string   "value",                 limit: 255
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "confirmed"
    t.datetime "confirmation_datetime"
    t.string   "confirmation_token",    limit: 255
    t.string   "creation_reason",       limit: 255
    t.text     "notes",                             default: ""
    t.text     "notes_invisible",                   default: ""
    t.integer  "somebody_id"
    t.integer  "creator_id"
  end

  add_index "emails", ["creator_id"], name: "index_emails_on_creator_id", using: :btree
  add_index "emails", ["profile_id"], name: "index_emails_on_profile_id", using: :btree
  add_index "emails", ["somebody_id"], name: "index_emails_on_somebody_id", using: :btree

  create_table "faq_transactions", force: :cascade do |t|
    t.integer  "faq_id"
    t.string   "operation",              limit: 255
    t.integer  "creator_id"
    t.text     "question_before"
    t.text     "question_after"
    t.text     "answer_before"
    t.text     "answer_after"
    t.boolean  "phantom_before"
    t.boolean  "phantom_after"
    t.string   "creation_reason_before", limit: 255
    t.string   "creation_reason_after",  limit: 255
    t.text     "notes_before"
    t.text     "notes_after"
    t.text     "notes_invisible_before"
    t.text     "notes_invisible_after"
    t.integer  "somebody_id_before"
    t.integer  "somebody_id_after"
    t.datetime "created_at"
  end

  add_index "faq_transactions", ["creator_id"], name: "index_faq_transactions_on_creator_id", using: :btree
  add_index "faq_transactions", ["faq_id"], name: "index_faq_transactions_on_faq_id", using: :btree

  create_table "faqs", force: :cascade do |t|
    t.text     "question"
    t.text     "answer"
    t.boolean  "phantom",                     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "creation_reason", limit: 255
    t.text     "notes",                       default: ""
    t.text     "notes_invisible",             default: ""
    t.integer  "somebody_id"
    t.integer  "creator_id"
  end

  add_index "faqs", ["creator_id"], name: "index_faqs_on_creator_id", using: :btree
  add_index "faqs", ["somebody_id"], name: "index_faqs_on_somebody_id", using: :btree

  create_table "galleries", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "content"
    t.string   "image",      limit: 255
    t.integer  "creator_id"
    t.boolean  "phantom",                default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "generations", force: :cascade do |t|
    t.citext   "name"
    t.text     "content"
    t.integer  "model_id"
    t.string   "cached_model", limit: 255
    t.integer  "creator_id"
    t.boolean  "phantom"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "from"
    t.date     "to"
    t.text     "preview"
  end

  add_index "generations", ["creator_id"], name: "index_generations_on_creator_id", using: :btree
  add_index "generations", ["model_id"], name: "index_generations_on_model_id", using: :btree

  create_table "ipgeobase_ips", id: false, force: :cascade do |t|
    t.integer "start_ip",  limit: 8
    t.integer "end_ip",    limit: 8
    t.integer "region_id"
  end

  add_index "ipgeobase_ips", ["region_id"], name: "index_ipgeobase_ips_on_region_id", using: :btree
  add_index "ipgeobase_ips", ["start_ip"], name: "index_ipgeobase_ips_on_start_ip", using: :btree

  create_table "ipgeobase_regions", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "ancestry",          limit: 255
    t.text     "names_depth_cache"
    t.integer  "region_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ipgeobase_regions", ["ancestry"], name: "index_ipgeobase_regions_on_ancestry", using: :btree

  create_table "metro", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "models", force: :cascade do |t|
    t.integer  "brand_id"
    t.string   "cached_brand", limit: 255
    t.citext   "name"
    t.text     "content"
    t.integer  "creator_id"
    t.boolean  "phantom"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slang",        limit: 255
    t.date     "from"
    t.date     "to"
    t.text     "preview"
  end

  add_index "models", ["brand_id"], name: "index_models_on_brand_id", using: :btree
  add_index "models", ["creator_id"], name: "index_models_on_creator_id", using: :btree

  create_table "modifications", force: :cascade do |t|
    t.citext   "name"
    t.text     "content"
    t.integer  "generation_id"
    t.string   "cached_generation", limit: 255
    t.integer  "creator_id"
    t.boolean  "phantom"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "from"
    t.date     "to"
  end

  add_index "modifications", ["creator_id"], name: "index_modifications_on_creator_id", using: :btree
  add_index "modifications", ["generation_id"], name: "index_modifications_on_generation_id", using: :btree

  create_table "name_transactions", force: :cascade do |t|
    t.integer  "name_id"
    t.string   "operation",              limit: 255
    t.integer  "creator_id"
    t.string   "surname_before",         limit: 255
    t.string   "surname_after",          limit: 255
    t.string   "name_before",            limit: 255
    t.string   "name_after",             limit: 255
    t.string   "patronymic_before",      limit: 255
    t.string   "patronymic_after",       limit: 255
    t.integer  "profile_id_before"
    t.integer  "profile_id_after"
    t.string   "creation_reason_before", limit: 255
    t.string   "creation_reason_after",  limit: 255
    t.text     "notes_before"
    t.text     "notes_after"
    t.text     "notes_invisible_before"
    t.text     "notes_invisible_after"
    t.integer  "somebody_id_before"
    t.integer  "somebody_id_after"
    t.datetime "created_at"
  end

  add_index "name_transactions", ["creator_id"], name: "index_name_transactions_on_creator_id", using: :btree
  add_index "name_transactions", ["name_id"], name: "index_name_transactions_on_name_id", using: :btree

  create_table "names", force: :cascade do |t|
    t.string   "surname",         limit: 255
    t.string   "name",            limit: 255
    t.string   "patronymic",      limit: 255
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "creation_reason", limit: 255
    t.text     "notes",                       default: ""
    t.text     "notes_invisible",             default: ""
    t.integer  "somebody_id"
    t.integer  "creator_id"
  end

  add_index "names", ["creator_id"], name: "index_names_on_creator_id", using: :btree
  add_index "names", ["profile_id"], name: "index_names_on_profile_id", using: :btree
  add_index "names", ["somebody_id"], name: "index_names_on_somebody_id", using: :btree

  create_table "news", force: :cascade do |t|
    t.string   "title"
    t.string   "path"
    t.text     "intro"
    t.text     "body"
    t.datetime "date"
    t.integer  "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "attention"
  end

  create_table "opts_accumulators", force: :cascade do |t|
    t.integer  "voltage"
    t.integer  "battery_capacity"
    t.integer  "cold_cranking_amps"
    t.integer  "length"
    t.integer  "width"
    t.integer  "height"
    t.integer  "base_hold_down"
    t.integer  "layout"
    t.integer  "terminal_types"
    t.integer  "case_size"
    t.integer  "weight_filled"
    t.integer  "spare_info_id"
    t.integer  "creator_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "opts_accumulators", ["creator_id"], name: "index_opts_accumulators_on_creator_id", using: :btree
  add_index "opts_accumulators", ["spare_info_id"], name: "index_opts_accumulators_on_spare_info_id", using: :btree

  create_table "order_deliveries", force: :cascade do |t|
    t.integer  "creator_id"
    t.integer  "somebody_id"
    t.integer  "postal_address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "order_deliveries", ["creator_id"], name: "index_order_deliveries_on_creator_id", using: :btree
  add_index "order_deliveries", ["postal_address_id"], name: "index_order_deliveries_on_postal_address_id", using: :btree
  add_index "order_deliveries", ["somebody_id"], name: "index_order_deliveries_on_somebody_id", using: :btree

  create_table "order_transactions", force: :cascade do |t|
    t.integer  "order_id"
    t.string   "operation",                       limit: 255
    t.integer  "creator_id"
    t.integer  "postal_address_id_before"
    t.integer  "postal_address_id_after"
    t.integer  "company_id_before"
    t.integer  "company_id_after"
    t.decimal  "delivery_cost_before"
    t.decimal  "delivery_cost_after"
    t.string   "status_before",                   limit: 255
    t.string   "status_after",                    limit: 255
    t.integer  "delivery_place_id_before"
    t.integer  "delivery_place_id_after"
    t.integer  "delivery_variant_id_before"
    t.integer  "delivery_variant_id_after"
    t.integer  "delivery_option_id_before"
    t.integer  "delivery_option_id_after"
    t.integer  "profile_id_before"
    t.integer  "profile_id_after"
    t.text     "cached_profile_before"
    t.text     "cached_profile_after"
    t.boolean  "full_prepayment_required_before"
    t.boolean  "full_prepayment_required_after"
    t.boolean  "legal_before"
    t.boolean  "legal_after"
    t.boolean  "phantom_before"
    t.boolean  "phantom_after"
    t.string   "token_before",                    limit: 255
    t.string   "token_after",                     limit: 255
    t.string   "track_number_before",             limit: 255
    t.string   "track_number_after",              limit: 255
    t.string   "creation_reason_before",          limit: 255
    t.string   "creation_reason_after",           limit: 255
    t.text     "notes_before"
    t.text     "notes_after"
    t.text     "notes_invisible_before"
    t.text     "notes_invisible_after"
    t.integer  "somebody_id_before"
    t.integer  "somebody_id_after"
    t.datetime "created_at"
  end

  add_index "order_transactions", ["creator_id"], name: "index_order_transactions_on_creator_id", using: :btree
  add_index "order_transactions", ["order_id"], name: "index_order_transactions_on_order_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "postal_address_id"
    t.integer  "company_id"
    t.decimal  "delivery_cost",                        precision: 8, scale: 2, default: 0.0
    t.string   "status",                   limit: 255,                         default: "open"
    t.integer  "delivery_place_id"
    t.integer  "delivery_variant_id"
    t.integer  "delivery_option_id"
    t.integer  "profile_id"
    t.text     "cached_profile"
    t.boolean  "full_prepayment_required"
    t.boolean  "legal"
    t.boolean  "phantom",                                                      default: true
    t.string   "token",                    limit: 255
    t.string   "track_number",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "creation_reason",          limit: 255
    t.text     "notes",                                                        default: ""
    t.text     "notes_invisible",                                              default: ""
    t.integer  "somebody_id"
    t.integer  "creator_id"
  end

  add_index "orders", ["company_id"], name: "index_orders_on_company_id", using: :btree
  add_index "orders", ["creator_id"], name: "index_orders_on_creator_id", using: :btree
  add_index "orders", ["delivery_option_id"], name: "index_orders_on_delivery_option_id", using: :btree
  add_index "orders", ["delivery_place_id"], name: "index_orders_on_delivery_place_id", using: :btree
  add_index "orders", ["delivery_variant_id"], name: "index_orders_on_delivery_variant_id", using: :btree
  add_index "orders", ["postal_address_id"], name: "index_orders_on_postal_address_id", using: :btree
  add_index "orders", ["profile_id"], name: "index_orders_on_profile_id", using: :btree
  add_index "orders", ["somebody_id"], name: "index_orders_on_somebody_id", using: :btree

  create_table "page_transactions", force: :cascade do |t|
    t.integer  "page_id"
    t.string   "operation",              limit: 255
    t.integer  "creator_id"
    t.string   "path_before",            limit: 255
    t.string   "path_after",             limit: 255
    t.text     "content_before"
    t.text     "content_after"
    t.text     "keywords_before"
    t.text     "keywords_after"
    t.text     "description_before"
    t.text     "description_after"
    t.string   "title_before",           limit: 255
    t.string   "title_after",            limit: 255
    t.string   "robots_before",          limit: 255
    t.string   "robots_after",           limit: 255
    t.string   "creation_reason_before", limit: 255
    t.string   "creation_reason_after",  limit: 255
    t.boolean  "phantom_before"
    t.boolean  "phantom_after"
    t.datetime "created_at"
    t.string   "redirect_url_before",    limit: 255
    t.string   "redirect_url_after",     limit: 255
  end

  add_index "page_transactions", ["creator_id"], name: "index_page_transactions_on_creator_id", using: :btree
  add_index "page_transactions", ["page_id"], name: "index_page_transactions_on_page_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.string   "path",            limit: 255
    t.text     "content"
    t.text     "keywords"
    t.text     "description"
    t.string   "title",           limit: 255
    t.string   "robots",          limit: 255
    t.integer  "creator_id"
    t.string   "creation_reason", limit: 255
    t.boolean  "phantom"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "redirect_url",    limit: 255
  end

  create_table "pages_uploads", id: false, force: :cascade do |t|
    t.integer "page_id"
    t.integer "upload_id"
  end

  create_table "passport_transactions", force: :cascade do |t|
    t.integer  "passport_id"
    t.string   "operation",                 limit: 255
    t.integer  "creator_id"
    t.string   "seriya_before",             limit: 255
    t.string   "seriya_after",              limit: 255
    t.string   "nomer_before",              limit: 255
    t.string   "nomer_after",               limit: 255
    t.string   "passport_vidan_before",     limit: 255
    t.string   "passport_vidan_after",      limit: 255
    t.date     "data_vidachi_before"
    t.date     "data_vidachi_after"
    t.string   "kod_podrazdeleniya_before", limit: 255
    t.string   "kod_podrazdeleniya_after",  limit: 255
    t.string   "gender_before",             limit: 255
    t.string   "gender_after",              limit: 255
    t.date     "data_rozhdeniya_before"
    t.date     "data_rozhdeniya_after"
    t.string   "mesto_rozhdeniya_before",   limit: 255
    t.string   "mesto_rozhdeniya_after",    limit: 255
    t.integer  "profile_id_before"
    t.integer  "profile_id_after"
    t.string   "creation_reason_before",    limit: 255
    t.string   "creation_reason_after",     limit: 255
    t.text     "notes_before"
    t.text     "notes_after"
    t.text     "notes_invisible_before"
    t.text     "notes_invisible_after"
    t.integer  "somebody_id_before"
    t.integer  "somebody_id_after"
    t.datetime "created_at"
  end

  add_index "passport_transactions", ["creator_id"], name: "index_passport_transactions_on_creator_id", using: :btree
  add_index "passport_transactions", ["passport_id"], name: "index_passport_transactions_on_passport_id", using: :btree

  create_table "passports", force: :cascade do |t|
    t.string   "seriya",             limit: 255
    t.string   "nomer",              limit: 255
    t.string   "passport_vidan",     limit: 255
    t.date     "data_vidachi"
    t.string   "kod_podrazdeleniya", limit: 255
    t.string   "gender",             limit: 255
    t.date     "data_rozhdeniya"
    t.string   "mesto_rozhdeniya",   limit: 255
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "creation_reason",    limit: 255
    t.text     "notes",                          default: ""
    t.text     "notes_invisible",                default: ""
    t.integer  "somebody_id"
    t.integer  "creator_id"
  end

  add_index "passports", ["creator_id"], name: "index_passports_on_creator_id", using: :btree
  add_index "passports", ["profile_id"], name: "index_passports_on_profile_id", using: :btree
  add_index "passports", ["somebody_id"], name: "index_passports_on_somebody_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.integer  "amount"
    t.integer  "creator_id"
    t.integer  "somebody_id"
    t.integer  "profile_id"
    t.integer  "postal_address_id"
    t.string   "payment_type",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payments", ["creator_id"], name: "index_payments_on_creator_id", using: :btree
  add_index "payments", ["postal_address_id"], name: "index_payments_on_postal_address_id", using: :btree
  add_index "payments", ["profile_id"], name: "index_payments_on_profile_id", using: :btree
  add_index "payments", ["somebody_id"], name: "index_payments_on_somebody_id", using: :btree

  create_table "phone_transactions", force: :cascade do |t|
    t.integer  "phone_id"
    t.string   "operation",                    limit: 255
    t.integer  "creator_id"
    t.string   "value_before",                 limit: 255
    t.string   "value_after",                  limit: 255
    t.boolean  "mobile_before"
    t.boolean  "mobile_after"
    t.integer  "profile_id_before"
    t.integer  "profile_id_after"
    t.boolean  "confirmed_before"
    t.boolean  "confirmed_after"
    t.datetime "confirmation_datetime_before"
    t.datetime "confirmation_datetime_after"
    t.string   "confirmation_token_before",    limit: 255
    t.string   "confirmation_token_after",     limit: 255
    t.string   "creation_reason_before",       limit: 255
    t.string   "creation_reason_after",        limit: 255
    t.text     "notes_before"
    t.text     "notes_after"
    t.text     "notes_invisible_before"
    t.text     "notes_invisible_after"
    t.integer  "somebody_id_before"
    t.integer  "somebody_id_after"
    t.datetime "created_at"
  end

  add_index "phone_transactions", ["creator_id"], name: "index_phone_transactions_on_creator_id", using: :btree
  add_index "phone_transactions", ["phone_id"], name: "index_phone_transactions_on_phone_id", using: :btree

  create_table "phones", force: :cascade do |t|
    t.string   "value",                 limit: 255
    t.boolean  "mobile"
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "confirmed"
    t.datetime "confirmation_datetime"
    t.string   "confirmation_token",    limit: 255
    t.string   "creation_reason",       limit: 255
    t.text     "notes",                             default: ""
    t.text     "notes_invisible",                   default: ""
    t.integer  "somebody_id"
    t.integer  "creator_id"
  end

  add_index "phones", ["creator_id"], name: "index_phones_on_creator_id", using: :btree
  add_index "phones", ["profile_id"], name: "index_phones_on_profile_id", using: :btree
  add_index "phones", ["somebody_id"], name: "index_phones_on_somebody_id", using: :btree

  create_table "postal_address_transactions", force: :cascade do |t|
    t.integer  "postal_address_id"
    t.string   "operation",                limit: 255
    t.integer  "creator_id"
    t.string   "postcode_before",          limit: 255
    t.string   "postcode_after",           limit: 255
    t.string   "region_before",            limit: 255
    t.string   "region_after",             limit: 255
    t.string   "city_before",              limit: 255
    t.string   "city_after",               limit: 255
    t.string   "street_before",            limit: 255
    t.string   "street_after",             limit: 255
    t.string   "house_before",             limit: 255
    t.string   "house_after",              limit: 255
    t.boolean  "stand_alone_house_before"
    t.boolean  "stand_alone_house_after"
    t.string   "room_before",              limit: 255
    t.string   "room_after",               limit: 255
    t.string   "creation_reason_before",   limit: 255
    t.string   "creation_reason_after",    limit: 255
    t.text     "notes_before"
    t.text     "notes_after"
    t.text     "notes_invisible_before"
    t.text     "notes_invisible_after"
    t.integer  "somebody_id_before"
    t.integer  "somebody_id_after"
    t.datetime "created_at"
  end

  add_index "postal_address_transactions", ["creator_id"], name: "index_postal_address_transactions_on_creator_id", using: :btree
  add_index "postal_address_transactions", ["postal_address_id"], name: "index_postal_address_transactions_on_postal_address_id", using: :btree

  create_table "postal_addresses", force: :cascade do |t|
    t.string   "postcode",          limit: 255
    t.string   "region",            limit: 255
    t.string   "city",              limit: 255
    t.string   "street",            limit: 255
    t.string   "house",             limit: 255
    t.boolean  "stand_alone_house"
    t.string   "room",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "creation_reason",   limit: 255
    t.text     "notes",                         default: ""
    t.text     "notes_invisible",               default: ""
    t.integer  "somebody_id"
    t.integer  "creator_id"
  end

  add_index "postal_addresses", ["creator_id"], name: "index_postal_addresses_on_creator_id", using: :btree
  add_index "postal_addresses", ["somebody_id"], name: "index_postal_addresses_on_somebody_id", using: :btree

  create_table "product_transactions", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "operation",                  limit: 255
    t.integer  "creator_id"
    t.string   "catalog_number_before",      limit: 255
    t.string   "catalog_number_after",       limit: 255
    t.integer  "brand_id_before"
    t.integer  "brand_id_after"
    t.string   "cached_brand_before",        limit: 255
    t.string   "cached_brand_after",         limit: 255
    t.string   "cached_order_before",        limit: 255
    t.string   "cached_order_after",         limit: 255
    t.string   "short_name_before",          limit: 255
    t.string   "short_name_after",           limit: 255
    t.text     "long_name_before"
    t.text     "long_name_after"
    t.integer  "quantity_ordered_before"
    t.integer  "quantity_ordered_after"
    t.integer  "quantity_available_before"
    t.integer  "quantity_available_after"
    t.integer  "min_days_before"
    t.integer  "min_days_after"
    t.integer  "max_days_before"
    t.integer  "max_days_after"
    t.decimal  "buy_cost_before"
    t.decimal  "buy_cost_after"
    t.decimal  "sell_cost_before"
    t.decimal  "sell_cost_after"
    t.boolean  "hide_catalog_number_before"
    t.boolean  "hide_catalog_number_after"
    t.string   "status_before",              limit: 255
    t.string   "status_after",               limit: 255
    t.integer  "probability_before"
    t.integer  "probability_after"
    t.integer  "product_id_before"
    t.integer  "product_id_after"
    t.integer  "order_id_before"
    t.integer  "order_id_after"
    t.integer  "supplier_id_before"
    t.integer  "supplier_id_after"
    t.string   "creation_reason_before",     limit: 255
    t.string   "creation_reason_after",      limit: 255
    t.text     "notes_before"
    t.text     "notes_after"
    t.text     "notes_invisible_before"
    t.text     "notes_invisible_after"
    t.integer  "somebody_id_before"
    t.integer  "somebody_id_after"
    t.datetime "created_at"
  end

  add_index "product_transactions", ["creator_id"], name: "index_product_transactions_on_creator_id", using: :btree
  add_index "product_transactions", ["product_id"], name: "index_product_transactions_on_product_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "catalog_number",      limit: 255
    t.integer  "brand_id"
    t.string   "cached_brand",        limit: 255
    t.string   "cached_order",        limit: 255
    t.string   "short_name",          limit: 255
    t.text     "long_name"
    t.integer  "quantity_ordered"
    t.integer  "quantity_available"
    t.integer  "min_days"
    t.integer  "max_days"
    t.decimal  "buy_cost",                        precision: 8, scale: 2
    t.decimal  "sell_cost",                       precision: 8, scale: 2
    t.boolean  "hide_catalog_number",                                     default: false
    t.string   "status",              limit: 255
    t.integer  "probability"
    t.integer  "product_id"
    t.integer  "order_id"
    t.integer  "supplier_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "creation_reason",     limit: 255
    t.text     "notes",                                                   default: ""
    t.text     "notes_invisible",                                         default: ""
    t.integer  "somebody_id"
    t.integer  "creator_id"
  end

  add_index "products", ["creator_id"], name: "index_products_on_creator_id", using: :btree
  add_index "products", ["order_id"], name: "index_products_on_order_id", using: :btree
  add_index "products", ["product_id"], name: "index_products_on_product_id", using: :btree
  add_index "products", ["somebody_id"], name: "index_products_on_somebody_id", using: :btree
  add_index "products", ["supplier_id"], name: "index_products_on_supplier_id", using: :btree

  create_table "profile_transactions", force: :cascade do |t|
    t.integer  "profile_id"
    t.string   "operation",               limit: 255
    t.integer  "creator_id"
    t.text     "cached_names_before"
    t.text     "cached_names_after"
    t.text     "cached_phones_before"
    t.text     "cached_phones_after"
    t.text     "cached_emails_before"
    t.text     "cached_emails_after"
    t.text     "cached_passports_before"
    t.text     "cached_passports_after"
    t.string   "creation_reason_before",  limit: 255
    t.string   "creation_reason_after",   limit: 255
    t.text     "notes_before"
    t.text     "notes_after"
    t.text     "notes_invisible_before"
    t.text     "notes_invisible_after"
    t.integer  "somebody_id_before"
    t.integer  "somebody_id_after"
    t.datetime "created_at"
  end

  add_index "profile_transactions", ["creator_id"], name: "index_profile_transactions_on_creator_id", using: :btree
  add_index "profile_transactions", ["profile_id"], name: "index_profile_transactions_on_profile_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.text     "cached_names"
    t.text     "cached_phones"
    t.text     "cached_emails"
    t.text     "cached_passports"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "creation_reason",  limit: 255
    t.text     "notes",                        default: ""
    t.text     "notes_invisible",              default: ""
    t.integer  "somebody_id"
    t.integer  "creator_id"
  end

  add_index "profiles", ["creator_id"], name: "index_profiles_on_creator_id", using: :btree
  add_index "profiles", ["somebody_id"], name: "index_profiles_on_somebody_id", using: :btree

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", limit: 255, null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "somebodies", force: :cascade do |t|
    t.decimal  "discount",                                     precision: 8, scale: 2
    t.decimal  "prepayment",                                   precision: 8, scale: 2
    t.string   "role",                             limit: 255
    t.string   "auth_token",                       limit: 255
    t.string   "password_digest",                  limit: 255
    t.string   "password_reset_token",             limit: 255
    t.datetime "password_reset_sent_at"
    t.string   "ipgeobase_name",                   limit: 255
    t.string   "ipgeobase_names_depth_cache",      limit: 255
    t.string   "accept_language",                  limit: 255
    t.string   "user_agent",                       limit: 255
    t.integer  "cached_russian_time_zone_auto_id"
    t.integer  "russian_time_zone_manual_id"
    t.boolean  "use_auto_russian_time_zone",                                           default: true
    t.inet     "remote_ip"
    t.string   "creation_reason",                  limit: 255
    t.text     "notes"
    t.text     "notes_invisible"
    t.integer  "creator_id"
    t.boolean  "phantom",                                                              default: false
    t.boolean  "logout_from_other_places",                                             default: true
    t.text     "chat"
    t.integer  "place_id"
    t.string   "post",                             limit: 255
    t.integer  "profile_id"
    t.text     "cached_profile"
    t.decimal  "cached_debit",                                 precision: 8, scale: 2, default: 0.0
    t.decimal  "cached_credit",                                precision: 8, scale: 2, default: 0.0
    t.string   "type",                             limit: 255
    t.string   "order_rule",                       limit: 255
    t.integer  "stats_count"
    t.datetime "touch_confirm"
    t.text     "cached_location"
    t.string   "cached_title",                     limit: 255
    t.text     "cached_referrer"
    t.text     "first_referrer"
    t.string   "cached_screen_width",              limit: 255
    t.string   "cached_screen_height",             limit: 255
    t.string   "cached_client_width",              limit: 255
    t.string   "cached_client_height",             limit: 255
    t.string   "cached_talk",                      limit: 255
    t.integer  "unread_talks",                                                         default: 0
    t.integer  "total_talks",                                                          default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "bot",                                                                  default: false
  end

  add_index "somebodies", ["creator_id"], name: "index_somebodies_on_creator_id", using: :btree
  add_index "somebodies", ["type", "auth_token"], name: "index_somebodies_on_type_and_auth_token", unique: true, using: :btree

  create_table "somebody_transactions", force: :cascade do |t|
    t.integer  "somebody_id"
    t.string   "operation",                               limit: 255
    t.integer  "creator_id"
    t.decimal  "discount_before"
    t.decimal  "discount_after"
    t.decimal  "prepayment_before"
    t.decimal  "prepayment_after"
    t.string   "role_before",                             limit: 255
    t.string   "role_after",                              limit: 255
    t.string   "auth_token_before",                       limit: 255
    t.string   "auth_token_after",                        limit: 255
    t.string   "password_digest_before",                  limit: 255
    t.string   "password_digest_after",                   limit: 255
    t.string   "password_reset_token_before",             limit: 255
    t.string   "password_reset_token_after",              limit: 255
    t.datetime "password_reset_sent_at_before"
    t.datetime "password_reset_sent_at_after"
    t.string   "ipgeobase_name_before",                   limit: 255
    t.string   "ipgeobase_name_after",                    limit: 255
    t.string   "ipgeobase_names_depth_cache_before",      limit: 255
    t.string   "ipgeobase_names_depth_cache_after",       limit: 255
    t.string   "accept_language_before",                  limit: 255
    t.string   "accept_language_after",                   limit: 255
    t.string   "user_agent_before",                       limit: 255
    t.string   "user_agent_after",                        limit: 255
    t.integer  "cached_russian_time_zone_auto_id_before"
    t.integer  "cached_russian_time_zone_auto_id_after"
    t.integer  "russian_time_zone_manual_id_before"
    t.integer  "russian_time_zone_manual_id_after"
    t.boolean  "use_auto_russian_time_zone_before"
    t.boolean  "use_auto_russian_time_zone_after"
    t.inet     "remote_ip_before"
    t.inet     "remote_ip_after"
    t.string   "creation_reason_before",                  limit: 255
    t.string   "creation_reason_after",                   limit: 255
    t.text     "notes_before"
    t.text     "notes_after"
    t.text     "notes_invisible_before"
    t.text     "notes_invisible_after"
    t.boolean  "phantom_before"
    t.boolean  "phantom_after"
    t.boolean  "logout_from_other_places_before"
    t.boolean  "logout_from_other_places_after"
    t.boolean  "online_before"
    t.boolean  "online_after"
    t.text     "chat_before"
    t.text     "chat_after"
    t.integer  "place_id_before"
    t.integer  "place_id_after"
    t.string   "post_before",                             limit: 255
    t.string   "post_after",                              limit: 255
    t.integer  "profile_id_before"
    t.integer  "profile_id_after"
    t.text     "cached_profile_before"
    t.text     "cached_profile_after"
    t.decimal  "cached_debit_before"
    t.decimal  "cached_debit_after"
    t.decimal  "cached_credit_before"
    t.decimal  "cached_credit_after"
    t.string   "type_before",                             limit: 255
    t.string   "type_after",                              limit: 255
    t.string   "order_rule_before",                       limit: 255
    t.string   "order_rule_after",                        limit: 255
    t.integer  "stats_count_before"
    t.integer  "stats_count_after"
    t.datetime "touch_confirm_before"
    t.datetime "touch_confirm_after"
    t.text     "cached_location_before"
    t.text     "cached_location_after"
    t.string   "cached_title_before",                     limit: 255
    t.string   "cached_title_after",                      limit: 255
    t.text     "cached_referrer_before"
    t.text     "cached_referrer_after"
    t.text     "first_referrer_before"
    t.text     "first_referrer_after"
    t.string   "cached_screen_width_before",              limit: 255
    t.string   "cached_screen_width_after",               limit: 255
    t.string   "cached_screen_height_before",             limit: 255
    t.string   "cached_screen_height_after",              limit: 255
    t.string   "cached_client_width_before",              limit: 255
    t.string   "cached_client_width_after",               limit: 255
    t.string   "cached_client_height_before",             limit: 255
    t.string   "cached_client_height_after",              limit: 255
    t.string   "cached_talk_before",                      limit: 255
    t.string   "cached_talk_after",                       limit: 255
    t.integer  "unread_talks_before"
    t.integer  "unread_talks_after"
    t.integer  "total_talks_before"
    t.integer  "total_talks_after"
    t.datetime "created_at"
    t.boolean  "bot_before"
    t.boolean  "bot_after"
  end

  add_index "somebody_transactions", ["creator_id"], name: "index_somebody_transactions_on_creator_id", using: :btree
  add_index "somebody_transactions", ["somebody_id"], name: "index_somebody_transactions_on_somebody_id", using: :btree

  create_table "spare_applicabilities", force: :cascade do |t|
    t.integer  "spare_info_id"
    t.integer  "brand_id"
    t.integer  "model_id"
    t.integer  "generation_id"
    t.integer  "modification_id"
    t.string   "cached_brand",        limit: 255
    t.string   "cached_model",        limit: 255
    t.string   "cached_generation",   limit: 255
    t.string   "cached_modification", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cached_spare_info",   limit: 255
    t.text     "notes"
    t.text     "notes_invisible"
  end

  add_index "spare_applicabilities", ["brand_id"], name: "index_spare_applicabilities_on_brand_id", using: :btree
  add_index "spare_applicabilities", ["generation_id"], name: "index_spare_applicabilities_on_generation_id", using: :btree
  add_index "spare_applicabilities", ["model_id"], name: "index_spare_applicabilities_on_model_id", using: :btree
  add_index "spare_applicabilities", ["modification_id"], name: "index_spare_applicabilities_on_modification_id", using: :btree
  add_index "spare_applicabilities", ["spare_info_id"], name: "index_spare_applicabilities_on_spare_info_id", using: :btree

  create_table "spare_catalog_tokens", force: :cascade do |t|
    t.integer  "spare_catalog_id"
    t.string   "name"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "weight",           default: 1
  end

  add_index "spare_catalog_tokens", ["spare_catalog_id"], name: "index_spare_catalog_tokens_on_spare_catalog_id", using: :btree

  create_table "spare_catalogs", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "intro"
    t.text     "page"
    t.string   "opt"
    t.integer  "shows"
  end

  create_table "spare_infos", force: :cascade do |t|
    t.string   "catalog_number",       limit: 255
    t.integer  "brand_id"
    t.string   "cached_brand",         limit: 255
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                 limit: 255
    t.string   "cached_spare_catalog", limit: 255
    t.integer  "spare_catalog_id"
    t.text     "notes"
    t.text     "notes_invisible"
    t.string   "image1"
    t.string   "image2"
    t.string   "image3"
    t.string   "image4"
    t.string   "image5"
    t.string   "image6"
    t.string   "image7"
    t.string   "image8"
    t.string   "file1"
    t.string   "file2"
    t.string   "file3"
    t.string   "file4"
    t.string   "file5"
    t.string   "file6"
    t.string   "file7"
    t.string   "file8"
    t.hstore   "hstore"
    t.integer  "shows"
  end

  add_index "spare_infos", ["brand_id"], name: "index_spare_infos_on_brand_id", using: :btree
  add_index "spare_infos", ["spare_catalog_id"], name: "index_spare_infos_on_spare_catalog_id", using: :btree

  create_table "spare_replacements", force: :cascade do |t|
    t.integer  "from_spare_info_id"
    t.integer  "to_spare_info_id"
    t.string   "from_cached_spare_info"
    t.string   "to_cached_spare_info"
    t.boolean  "wrong"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notes"
    t.text     "notes_invisible"
    t.integer  "status"
  end

  add_index "spare_replacements", ["from_spare_info_id"], name: "index_spare_replacements_on_from_spare_info_id", using: :btree
  add_index "spare_replacements", ["to_spare_info_id"], name: "index_spare_replacements_on_to_spare_info_id", using: :btree

  create_table "stats", force: :cascade do |t|
    t.text     "location"
    t.string   "title",                     limit: 255
    t.text     "referrer"
    t.integer  "russian_time_zone_auto_id"
    t.integer  "screen_width"
    t.integer  "screen_height"
    t.integer  "client_width"
    t.integer  "client_height"
    t.integer  "somebody_id"
    t.boolean  "is_search"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stats", ["somebody_id"], name: "index_stats_on_somebody_id", using: :btree

  create_table "suppliers", force: :cascade do |t|
    t.integer  "creator_id"
    t.decimal  "debit",      precision: 8, scale: 2, default: 0.0
    t.decimal  "credit",     precision: 8, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "suppliers", ["creator_id"], name: "index_suppliers_on_creator_id", using: :btree

  create_table "talks", force: :cascade do |t|
    t.boolean  "read",                        default: false
    t.boolean  "received",                    default: false
    t.text     "cached_talk"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "creation_reason", limit: 255
    t.text     "notes",                       default: ""
    t.text     "notes_invisible",             default: ""
    t.integer  "somebody_id"
    t.integer  "creator_id"
    t.text     "text"
    t.string   "file",            limit: 255
    t.string   "file_name",       limit: 255
    t.boolean  "notified",                    default: false
  end

  add_index "talks", ["creator_id"], name: "index_talks_on_creator_id", using: :btree
  add_index "talks", ["somebody_id"], name: "index_talks_on_somebody_id", using: :btree

  create_table "tests", force: :cascade do |t|
    t.binary   "binary"
    t.boolean  "boolean"
    t.date     "date"
    t.datetime "datetime"
    t.decimal  "decimal"
    t.float    "float"
    t.integer  "integer"
    t.string   "string",     limit: 255
    t.text     "text"
    t.time     "time"
    t.datetime "timestamp"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "uploads", force: :cascade do |t|
    t.string   "upload",          limit: 255
    t.string   "content_type",    limit: 255
    t.integer  "file_size"
    t.integer  "somebody_id"
    t.string   "creation_reason", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "uploads", ["somebody_id"], name: "index_uploads_on_somebody_id", using: :btree

  create_table "warehouses", force: :cascade do |t|
    t.integer  "spare_info_id"
    t.integer  "count"
    t.integer  "price"
    t.integer  "place_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "warehouses", ["place_id"], name: "index_warehouses_on_place_id", using: :btree
  add_index "warehouses", ["spare_info_id"], name: "index_warehouses_on_spare_info_id", using: :btree

  add_foreign_key "callbacks", "somebodies"
end
