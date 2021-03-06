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

ActiveRecord::Schema.define(version: 20151016131254) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "citext"
  enable_extension "uuid-ossp"

  create_table "account_transactions", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "operation"
    t.integer  "creator_id"
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

  create_table "accounts", force: :cascade do |t|
    t.decimal  "debit",       precision: 8, scale: 2, default: 0.0
    t.decimal  "credit",      precision: 8, scale: 2, default: 0.0
    t.integer  "somebody_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts", ["somebody_id"], name: "index_accounts_on_somebody_id", using: :btree

  create_table "bots", force: :cascade do |t|
    t.string   "title"
    t.string   "user_agent"
    t.inet     "inet"
    t.boolean  "phantom"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "block",      default: false
  end

  create_table "brand_transactions", force: :cascade do |t|
    t.integer  "brand_id"
    t.string   "operation"
    t.integer  "creator_id"
    t.string   "name_before"
    t.string   "name_after"
    t.string   "path_before"
    t.string   "path_after"
    t.integer  "brand_id_before"
    t.integer  "brand_id_after"
    t.string   "image_before"
    t.string   "image_after"
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
  end

  add_index "brand_transactions", ["brand_id"], name: "index_brand_transactions_on_brand_id", using: :btree
  add_index "brand_transactions", ["creator_id"], name: "index_brand_transactions_on_creator_id", using: :btree

  create_table "brands", force: :cascade do |t|
    t.citext   "name"
    t.integer  "brand_id"
    t.string   "image"
    t.integer  "rating"
    t.text     "content"
    t.integer  "creator_id"
    t.boolean  "phantom"
    t.boolean  "is_brand"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "preview"
    t.boolean  "default_display"
    t.string   "opts",            default: [], array: true
    t.integer  "sign"
  end

  add_index "brands", ["brand_id"], name: "index_brands_on_brand_id", using: :btree
  add_index "brands", ["creator_id"], name: "index_brands_on_creator_id", using: :btree

  create_table "brands_spare_catalogs", id: false, force: :cascade do |t|
    t.integer "spare_catalog_id", null: false
    t.integer "brand_id",         null: false
  end

  create_table "calls", force: :cascade do |t|
    t.integer  "phone_id"
    t.integer  "somebody_id"
    t.string   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "calls", ["phone_id"], name: "index_calls_on_phone_id", using: :btree
  add_index "calls", ["somebody_id"], name: "index_calls_on_somebody_id", using: :btree

  create_table "car_transactions", force: :cascade do |t|
    t.integer  "car_id"
    t.string   "operation"
    t.integer  "creator_id"
    t.integer  "god_before"
    t.integer  "god_after"
    t.string   "period_before"
    t.string   "period_after"
    t.integer  "brand_id_before"
    t.integer  "brand_id_after"
    t.integer  "model_id_before"
    t.integer  "model_id_after"
    t.integer  "generation_id_before"
    t.integer  "generation_id_after"
    t.integer  "modification_id_before"
    t.integer  "modification_id_after"
    t.string   "dvigatel_before"
    t.string   "dvigatel_after"
    t.string   "tip_before"
    t.string   "tip_after"
    t.string   "moschnost_before"
    t.string   "moschnost_after"
    t.string   "privod_before"
    t.string   "privod_after"
    t.string   "tip_kuzova_before"
    t.string   "tip_kuzova_after"
    t.string   "kpp_before"
    t.string   "kpp_after"
    t.string   "kod_kuzova_before"
    t.string   "kod_kuzova_after"
    t.string   "kod_dvigatelya_before"
    t.string   "kod_dvigatelya_after"
    t.string   "rinok_before"
    t.string   "rinok_after"
    t.string   "vin_before"
    t.string   "vin_after"
    t.string   "frame_before"
    t.string   "frame_after"
    t.string   "vin_or_frame_before"
    t.string   "vin_or_frame_after"
    t.string   "komplektaciya_before"
    t.string   "komplektaciya_after"
    t.integer  "dverey_before"
    t.integer  "dverey_after"
    t.string   "rul_before"
    t.string   "rul_after"
    t.string   "car_number_before"
    t.string   "car_number_after"
    t.string   "creation_reason_before"
    t.string   "creation_reason_after"
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
    t.string   "period"
    t.integer  "brand_id"
    t.integer  "model_id"
    t.integer  "generation_id"
    t.integer  "modification_id"
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
    t.string   "vin_or_frame"
    t.string   "komplektaciya"
    t.integer  "dverey"
    t.string   "rul"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "car_number"
    t.string   "creation_reason"
    t.text     "notes",           default: ""
    t.text     "notes_invisible", default: ""
    t.integer  "somebody_id"
    t.integer  "creator_id"
    t.integer  "user_id"
  end

  add_index "cars", ["brand_id"], name: "index_cars_on_brand_id", using: :btree
  add_index "cars", ["creator_id"], name: "index_cars_on_creator_id", using: :btree
  add_index "cars", ["generation_id"], name: "index_cars_on_generation_id", using: :btree
  add_index "cars", ["model_id"], name: "index_cars_on_model_id", using: :btree
  add_index "cars", ["modification_id"], name: "index_cars_on_modification_id", using: :btree
  add_index "cars", ["somebody_id"], name: "index_cars_on_somebody_id", using: :btree
  add_index "cars", ["user_id"], name: "index_cars_on_user_id", using: :btree

  create_table "ckpages_pages", force: :cascade do |t|
    t.text     "path"
    t.text     "content"
    t.text     "keywords"
    t.text     "description"
    t.text     "title"
    t.text     "robots"
    t.text     "redirect_url"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.text     "title1"
    t.text     "url1"
    t.text     "title2"
    t.text     "url2"
    t.text     "title3"
    t.text     "url3"
    t.text     "title4"
    t.text     "url4"
    t.text     "title5"
    t.text     "url5"
  end

  create_table "ckpages_parts", force: :cascade do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ckpages_uploads", force: :cascade do |t|
    t.string   "file"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "content_type"
    t.integer  "file_size"
  end

  create_table "companies", force: :cascade do |t|
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
    t.string   "cached_legal_address"
    t.integer  "actual_address_id"
    t.string   "cached_actual_address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "creation_reason"
    t.text     "notes",                 default: ""
    t.text     "notes_invisible",       default: ""
    t.integer  "somebody_id"
    t.integer  "creator_id"
  end

  add_index "companies", ["actual_address_id"], name: "index_companies_on_actual_address_id", using: :btree
  add_index "companies", ["creator_id"], name: "index_companies_on_creator_id", using: :btree
  add_index "companies", ["legal_address_id"], name: "index_companies_on_legal_address_id", using: :btree
  add_index "companies", ["somebody_id"], name: "index_companies_on_somebody_id", using: :btree

  create_table "company_transactions", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "operation"
    t.integer  "creator_id"
    t.string   "ownership_before"
    t.string   "ownership_after"
    t.string   "name_before"
    t.string   "name_after"
    t.string   "inn_before"
    t.string   "inn_after"
    t.string   "kpp_before"
    t.string   "kpp_after"
    t.string   "ogrn_before"
    t.string   "ogrn_after"
    t.string   "account_before"
    t.string   "account_after"
    t.string   "bank_before"
    t.string   "bank_after"
    t.string   "bik_before"
    t.string   "bik_after"
    t.string   "correspondent_before"
    t.string   "correspondent_after"
    t.string   "okpo_before"
    t.string   "okpo_after"
    t.string   "okved_before"
    t.string   "okved_after"
    t.string   "okato_before"
    t.string   "okato_after"
    t.integer  "legal_address_id_before"
    t.integer  "legal_address_id_after"
    t.string   "cached_legal_address_before"
    t.string   "cached_legal_address_after"
    t.integer  "actual_address_id_before"
    t.integer  "actual_address_id_after"
    t.string   "cached_actual_address_before"
    t.string   "cached_actual_address_after"
    t.string   "creation_reason_before"
    t.string   "creation_reason_after"
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

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "deliveries_places", force: :cascade do |t|
    t.string   "name"
    t.text     "vertices"
    t.boolean  "realize",        default: true
    t.boolean  "active",         default: true
    t.integer  "z_index"
    t.boolean  "display_marker"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "price_url"
    t.string   "metro"
    t.boolean  "partner",        default: false, null: false
    t.string   "ycountry"
    t.string   "ycountry_code"
    t.string   "ycity"
    t.string   "ystreet"
    t.string   "yhouse"
    t.string   "ycity_code"
    t.string   "yphone"
    t.string   "ycompany_name"
    t.string   "ycontact_email"
    t.string   "ywork_time"
    t.string   "yogrn"
    t.integer  "faq_id"
    t.string   "email"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "phone3"
    t.string   "phone4"
    t.string   "phone5"
  end

  create_table "deliveries_variants", force: :cascade do |t|
    t.integer  "place_id"
    t.integer  "option_id"
    t.boolean  "active"
    t.integer  "sequence"
    t.string   "name"
    t.float    "delivery_cost"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "email_transactions", force: :cascade do |t|
    t.integer  "email_id"
    t.string   "operation"
    t.integer  "creator_id"
    t.string   "value_before"
    t.string   "value_after"
    t.integer  "profile_id_before"
    t.integer  "profile_id_after"
    t.boolean  "confirmed_before"
    t.boolean  "confirmed_after"
    t.datetime "confirmation_datetime_before"
    t.datetime "confirmation_datetime_after"
    t.string   "confirmation_token_before"
    t.string   "confirmation_token_after"
    t.string   "creation_reason_before"
    t.string   "creation_reason_after"
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
    t.string   "value"
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "confirmed"
    t.datetime "confirmation_datetime"
    t.string   "confirmation_token"
    t.string   "creation_reason"
    t.text     "notes",                 default: ""
    t.text     "notes_invisible",       default: ""
    t.integer  "somebody_id"
    t.integer  "creator_id"
  end

  add_index "emails", ["creator_id"], name: "index_emails_on_creator_id", using: :btree
  add_index "emails", ["profile_id"], name: "index_emails_on_profile_id", using: :btree
  add_index "emails", ["somebody_id"], name: "index_emails_on_somebody_id", using: :btree

  create_table "galleries", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.string   "image"
    t.integer  "creator_id"
    t.boolean  "phantom",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "generations", force: :cascade do |t|
    t.citext   "name"
    t.text     "content"
    t.integer  "model_id"
    t.string   "cached_model"
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
    t.string   "name"
    t.string   "ancestry"
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
    t.citext   "name"
    t.text     "content"
    t.integer  "creator_id"
    t.boolean  "phantom"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "from"
    t.date     "to"
    t.string   "slang"
    t.text     "preview"
  end

  add_index "models", ["brand_id"], name: "index_models_on_brand_id", using: :btree
  add_index "models", ["creator_id"], name: "index_models_on_creator_id", using: :btree

  create_table "modifications", force: :cascade do |t|
    t.citext   "name"
    t.text     "content"
    t.integer  "generation_id"
    t.string   "cached_generation"
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
    t.string   "operation"
    t.integer  "creator_id"
    t.string   "surname_before"
    t.string   "surname_after"
    t.string   "name_before"
    t.string   "name_after"
    t.string   "patronymic_before"
    t.string   "patronymic_after"
    t.integer  "profile_id_before"
    t.integer  "profile_id_after"
    t.string   "creation_reason_before"
    t.string   "creation_reason_after"
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
    t.string   "surname"
    t.string   "name"
    t.string   "patronymic"
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "creation_reason"
    t.text     "notes",           default: ""
    t.text     "notes_invisible", default: ""
    t.integer  "somebody_id"
    t.integer  "creator_id"
  end

  add_index "names", ["creator_id"], name: "index_names_on_creator_id", using: :btree
  add_index "names", ["profile_id"], name: "index_names_on_profile_id", using: :btree
  add_index "names", ["somebody_id"], name: "index_names_on_somebody_id", using: :btree

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
    t.integer  "spare_info_id"
    t.integer  "creator_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "opts_accumulators", ["creator_id"], name: "index_opts_accumulators_on_creator_id", using: :btree
  add_index "opts_accumulators", ["spare_info_id"], name: "index_opts_accumulators_on_spare_info_id", using: :btree

  create_table "opts_truck_tires", force: :cascade do |t|
    t.integer  "height"
    t.integer  "width"
    t.integer  "diameter"
    t.integer  "spare_info_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "load"
    t.integer  "speed"
    t.integer  "line"
    t.integer  "axle"
  end

  add_index "opts_truck_tires", ["spare_info_id"], name: "index_opts_truck_tires_on_spare_info_id", using: :btree

  create_table "order_transactions", force: :cascade do |t|
    t.integer  "order_id"
    t.string   "operation"
    t.integer  "creator_id"
    t.integer  "postal_address_id_before"
    t.integer  "postal_address_id_after"
    t.integer  "company_id_before"
    t.integer  "company_id_after"
    t.decimal  "delivery_cost_before"
    t.decimal  "delivery_cost_after"
    t.string   "status_before"
    t.string   "status_after"
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
    t.string   "token_before"
    t.string   "token_after"
    t.string   "track_number_before"
    t.string   "track_number_after"
    t.string   "creation_reason_before"
    t.string   "creation_reason_after"
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
    t.decimal  "delivery_cost",            precision: 8, scale: 2, default: 0.0
    t.string   "status",                                           default: "open"
    t.integer  "delivery_place_id"
    t.integer  "delivery_variant_id"
    t.integer  "delivery_option_id"
    t.integer  "profile_id"
    t.text     "cached_profile"
    t.boolean  "full_prepayment_required"
    t.boolean  "legal"
    t.boolean  "phantom",                                          default: true
    t.string   "token"
    t.string   "track_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "creation_reason"
    t.text     "notes",                                            default: ""
    t.text     "notes_invisible",                                  default: ""
    t.integer  "somebody_id"
    t.integer  "creator_id"
    t.integer  "user_id"
    t.integer  "deliveries_place_id"
  end

  add_index "orders", ["company_id"], name: "index_orders_on_company_id", using: :btree
  add_index "orders", ["creator_id"], name: "index_orders_on_creator_id", using: :btree
  add_index "orders", ["deliveries_place_id"], name: "index_orders_on_deliveries_place_id", using: :btree
  add_index "orders", ["delivery_option_id"], name: "index_orders_on_delivery_option_id", using: :btree
  add_index "orders", ["delivery_place_id"], name: "index_orders_on_delivery_place_id", using: :btree
  add_index "orders", ["delivery_variant_id"], name: "index_orders_on_delivery_variant_id", using: :btree
  add_index "orders", ["postal_address_id"], name: "index_orders_on_postal_address_id", using: :btree
  add_index "orders", ["profile_id"], name: "index_orders_on_profile_id", using: :btree
  add_index "orders", ["somebody_id"], name: "index_orders_on_somebody_id", using: :btree
  add_index "orders", ["token"], name: "index_orders_on_token", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "page_transactions", force: :cascade do |t|
    t.integer  "page_id"
    t.string   "operation"
    t.integer  "creator_id"
    t.string   "path_before"
    t.string   "path_after"
    t.text     "content_before"
    t.text     "content_after"
    t.text     "keywords_before"
    t.text     "keywords_after"
    t.text     "description_before"
    t.text     "description_after"
    t.string   "title_before"
    t.string   "title_after"
    t.string   "robots_before"
    t.string   "robots_after"
    t.string   "creation_reason_before"
    t.string   "creation_reason_after"
    t.boolean  "phantom_before"
    t.boolean  "phantom_after"
    t.datetime "created_at"
  end

  add_index "page_transactions", ["creator_id"], name: "index_page_transactions_on_creator_id", using: :btree
  add_index "page_transactions", ["page_id"], name: "index_page_transactions_on_page_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.string   "path"
    t.text     "content"
    t.text     "keywords"
    t.text     "description"
    t.string   "title"
    t.string   "robots"
    t.integer  "creator_id"
    t.string   "creation_reason"
    t.boolean  "phantom"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "redirect_url"
  end

  create_table "passport_transactions", force: :cascade do |t|
    t.integer  "passport_id"
    t.string   "operation"
    t.integer  "creator_id"
    t.string   "seriya_before"
    t.string   "seriya_after"
    t.string   "nomer_before"
    t.string   "nomer_after"
    t.string   "passport_vidan_before"
    t.string   "passport_vidan_after"
    t.date     "data_vidachi_before"
    t.date     "data_vidachi_after"
    t.string   "kod_podrazdeleniya_before"
    t.string   "kod_podrazdeleniya_after"
    t.string   "gender_before"
    t.string   "gender_after"
    t.date     "data_rozhdeniya_before"
    t.date     "data_rozhdeniya_after"
    t.string   "mesto_rozhdeniya_before"
    t.string   "mesto_rozhdeniya_after"
    t.integer  "profile_id_before"
    t.integer  "profile_id_after"
    t.string   "creation_reason_before"
    t.string   "creation_reason_after"
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
    t.string   "seriya"
    t.string   "nomer"
    t.string   "passport_vidan"
    t.date     "data_vidachi"
    t.string   "kod_podrazdeleniya"
    t.string   "gender"
    t.date     "data_rozhdeniya"
    t.string   "mesto_rozhdeniya"
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "creation_reason"
    t.text     "notes",              default: ""
    t.text     "notes_invisible",    default: ""
    t.integer  "somebody_id"
    t.integer  "creator_id"
  end

  add_index "passports", ["creator_id"], name: "index_passports_on_creator_id", using: :btree
  add_index "passports", ["profile_id"], name: "index_passports_on_profile_id", using: :btree
  add_index "passports", ["somebody_id"], name: "index_passports_on_somebody_id", using: :btree

  create_table "phone_transactions", force: :cascade do |t|
    t.integer  "phone_id"
    t.string   "operation"
    t.integer  "creator_id"
    t.string   "value_before"
    t.string   "value_after"
    t.boolean  "mobile_before"
    t.boolean  "mobile_after"
    t.integer  "profile_id_before"
    t.integer  "profile_id_after"
    t.boolean  "confirmed_before"
    t.boolean  "confirmed_after"
    t.datetime "confirmation_datetime_before"
    t.datetime "confirmation_datetime_after"
    t.string   "confirmation_token_before"
    t.string   "confirmation_token_after"
    t.string   "creation_reason_before"
    t.string   "creation_reason_after"
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
    t.string   "value"
    t.boolean  "mobile"
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "confirmed"
    t.datetime "confirmation_datetime"
    t.string   "confirmation_token"
    t.string   "creation_reason"
    t.text     "notes",                 default: ""
    t.text     "notes_invisible",       default: ""
    t.integer  "somebody_id"
    t.integer  "creator_id"
  end

  add_index "phones", ["creator_id"], name: "index_phones_on_creator_id", using: :btree
  add_index "phones", ["profile_id"], name: "index_phones_on_profile_id", using: :btree
  add_index "phones", ["somebody_id"], name: "index_phones_on_somebody_id", using: :btree

  create_table "postal_address_transactions", force: :cascade do |t|
    t.integer  "postal_address_id"
    t.string   "operation"
    t.integer  "creator_id"
    t.string   "postcode_before"
    t.string   "postcode_after"
    t.string   "region_before"
    t.string   "region_after"
    t.string   "city_before"
    t.string   "city_after"
    t.string   "street_before"
    t.string   "street_after"
    t.string   "house_before"
    t.string   "house_after"
    t.boolean  "stand_alone_house_before"
    t.boolean  "stand_alone_house_after"
    t.string   "room_before"
    t.string   "room_after"
    t.string   "creation_reason_before"
    t.string   "creation_reason_after"
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
    t.string   "postcode"
    t.string   "region"
    t.string   "city"
    t.string   "street"
    t.string   "house"
    t.boolean  "stand_alone_house"
    t.string   "room"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "creation_reason"
    t.text     "notes",             default: ""
    t.text     "notes_invisible",   default: ""
    t.integer  "somebody_id"
    t.integer  "creator_id"
    t.integer  "user_id"
    t.boolean  "is_moscow"
  end

  add_index "postal_addresses", ["creator_id"], name: "index_postal_addresses_on_creator_id", using: :btree
  add_index "postal_addresses", ["somebody_id"], name: "index_postal_addresses_on_somebody_id", using: :btree
  add_index "postal_addresses", ["user_id"], name: "index_postal_addresses_on_user_id", using: :btree

  create_table "product_transactions", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "operation"
    t.integer  "creator_id"
    t.string   "catalog_number_before"
    t.string   "catalog_number_after"
    t.integer  "brand_id_before"
    t.integer  "brand_id_after"
    t.string   "short_name_before"
    t.string   "short_name_after"
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
    t.string   "status_before"
    t.string   "status_after"
    t.integer  "probability_before"
    t.integer  "probability_after"
    t.integer  "order_id_before"
    t.integer  "order_id_after"
    t.string   "creation_reason_before"
    t.string   "creation_reason_after"
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
    t.string   "catalog_number"
    t.integer  "brand_id"
    t.string   "title"
    t.text     "titles",                                      default: [],    array: true
    t.integer  "quantity_ordered"
    t.integer  "quantity_available"
    t.integer  "min_days"
    t.integer  "max_days"
    t.decimal  "buy_cost",            precision: 8, scale: 2
    t.decimal  "sell_cost",           precision: 8, scale: 2
    t.boolean  "hide_catalog_number",                         default: false
    t.integer  "status"
    t.integer  "probability"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "creation_reason"
    t.text     "notes",                                       default: ""
    t.text     "notes_invisible",                             default: ""
    t.integer  "somebody_id"
    t.integer  "creator_id"
    t.integer  "user_id"
    t.integer  "deliveries_place_id"
  end

  add_index "products", ["creator_id"], name: "index_products_on_creator_id", using: :btree
  add_index "products", ["deliveries_place_id"], name: "index_products_on_deliveries_place_id", using: :btree
  add_index "products", ["order_id"], name: "index_products_on_order_id", using: :btree
  add_index "products", ["somebody_id"], name: "index_products_on_somebody_id", using: :btree
  add_index "products", ["user_id"], name: "index_products_on_user_id", using: :btree

  create_table "profile_transactions", force: :cascade do |t|
    t.integer  "profile_id"
    t.string   "operation"
    t.integer  "creator_id"
    t.text     "cached_names_before"
    t.text     "cached_names_after"
    t.text     "cached_phones_before"
    t.text     "cached_phones_after"
    t.text     "cached_emails_before"
    t.text     "cached_emails_after"
    t.text     "cached_passports_before"
    t.text     "cached_passports_after"
    t.string   "creation_reason_before"
    t.string   "creation_reason_after"
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
    t.string   "creation_reason"
    t.text     "notes",            default: ""
    t.text     "notes_invisible",  default: ""
    t.integer  "somebody_id"
    t.integer  "creator_id"
  end

  add_index "profiles", ["creator_id"], name: "index_profiles_on_creator_id", using: :btree
  add_index "profiles", ["somebody_id"], name: "index_profiles_on_somebody_id", using: :btree

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "somebodies", force: :cascade do |t|
    t.decimal  "discount",                    precision: 8, scale: 2
    t.decimal  "prepayment",                  precision: 8, scale: 2
    t.string   "role"
    t.string   "auth_token"
    t.string   "password_digest"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "ipgeobase_name"
    t.string   "ipgeobase_names_depth_cache"
    t.string   "accept_language"
    t.string   "user_agent"
    t.inet     "remote_ip"
    t.string   "creation_reason"
    t.text     "notes"
    t.text     "notes_invisible"
    t.integer  "creator_id"
    t.boolean  "phantom",                                             default: false
    t.boolean  "logout_from_other_places",                            default: true
    t.integer  "profile_id"
    t.text     "cached_profile"
    t.decimal  "cached_debit",                precision: 8, scale: 2, default: 0.0
    t.decimal  "cached_credit",               precision: 8, scale: 2, default: 0.0
    t.string   "type"
    t.string   "order_rule"
    t.text     "location"
    t.text     "referrer"
    t.text     "first_referrer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "somebodies", ["creator_id"], name: "index_somebodies_on_creator_id", using: :btree
  add_index "somebodies", ["remote_ip"], name: "index_somebodies_on_remote_ip", using: :btree
  add_index "somebodies", ["type", "auth_token"], name: "index_somebodies_on_type_and_auth_token", unique: true, using: :btree
  add_index "somebodies", ["user_agent"], name: "index_somebodies_on_user_agent", using: :btree

  create_table "somebody_transactions", force: :cascade do |t|
    t.integer  "somebody_id"
    t.string   "operation"
    t.integer  "creator_id"
    t.decimal  "discount_before"
    t.decimal  "discount_after"
    t.decimal  "prepayment_before"
    t.decimal  "prepayment_after"
    t.string   "role_before"
    t.string   "role_after"
    t.string   "auth_token_before"
    t.string   "auth_token_after"
    t.string   "password_digest_before"
    t.string   "password_digest_after"
    t.string   "password_reset_token_before"
    t.string   "password_reset_token_after"
    t.datetime "password_reset_sent_at_before"
    t.datetime "password_reset_sent_at_after"
    t.string   "ipgeobase_name_before"
    t.string   "ipgeobase_name_after"
    t.string   "ipgeobase_names_depth_cache_before"
    t.string   "ipgeobase_names_depth_cache_after"
    t.string   "accept_language_before"
    t.string   "accept_language_after"
    t.string   "user_agent_before"
    t.string   "user_agent_after"
    t.integer  "cached_russian_time_zone_auto_id_before"
    t.integer  "cached_russian_time_zone_auto_id_after"
    t.inet     "remote_ip_before"
    t.inet     "remote_ip_after"
    t.string   "creation_reason_before"
    t.string   "creation_reason_after"
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
    t.boolean  "sound_before"
    t.boolean  "sound_after"
    t.text     "chat_before"
    t.text     "chat_after"
    t.integer  "profile_id_before"
    t.integer  "profile_id_after"
    t.text     "cached_profile_before"
    t.text     "cached_profile_after"
    t.decimal  "cached_debit_before"
    t.decimal  "cached_debit_after"
    t.decimal  "cached_credit_before"
    t.decimal  "cached_credit_after"
    t.string   "type_before"
    t.string   "type_after"
    t.string   "order_rule_before"
    t.string   "order_rule_after"
    t.integer  "stats_count_before"
    t.integer  "stats_count_after"
    t.datetime "touch_confirm_before"
    t.datetime "touch_confirm_after"
    t.text     "cached_location_before"
    t.text     "cached_location_after"
    t.string   "cached_title_before"
    t.string   "cached_title_after"
    t.text     "cached_referrer_before"
    t.text     "cached_referrer_after"
    t.text     "first_referrer_before"
    t.text     "first_referrer_after"
    t.string   "cached_screen_width_before"
    t.string   "cached_screen_width_after"
    t.string   "cached_screen_height_before"
    t.string   "cached_screen_height_after"
    t.string   "cached_client_width_before"
    t.string   "cached_client_width_after"
    t.string   "cached_client_height_before"
    t.string   "cached_client_height_after"
    t.string   "cached_talk_before"
    t.string   "cached_talk_after"
    t.string   "transport_before"
    t.string   "transport_after"
    t.integer  "unread_talks_before"
    t.integer  "unread_talks_after"
    t.integer  "total_talks_before"
    t.integer  "total_talks_after"
    t.integer  "default_addressee_id_before"
    t.integer  "default_addressee_id_after"
    t.datetime "created_at"
  end

  add_index "somebody_transactions", ["creator_id"], name: "index_somebody_transactions_on_creator_id", using: :btree
  add_index "somebody_transactions", ["somebody_id"], name: "index_somebody_transactions_on_somebody_id", using: :btree

  create_table "spare_applicabilities", force: :cascade do |t|
    t.integer  "spare_info_id"
    t.integer  "brand_id"
    t.integer  "model_id"
    t.integer  "generation_id"
    t.integer  "modification_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notes"
    t.text     "notes_invisible"
  end

  add_index "spare_applicabilities", ["brand_id"], name: "index_spare_applicabilities_on_brand_id", using: :btree
  add_index "spare_applicabilities", ["generation_id"], name: "index_spare_applicabilities_on_generation_id", using: :btree
  add_index "spare_applicabilities", ["model_id"], name: "index_spare_applicabilities_on_model_id", using: :btree
  add_index "spare_applicabilities", ["modification_id"], name: "index_spare_applicabilities_on_modification_id", using: :btree
  add_index "spare_applicabilities", ["spare_info_id"], name: "index_spare_applicabilities_on_spare_info_id", using: :btree

  create_table "spare_catalog_groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "ancestry"
  end

  create_table "spare_catalog_tokens", force: :cascade do |t|
    t.integer  "spare_catalog_id"
    t.string   "name"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "weight",           default: 1
  end

  add_index "spare_catalog_tokens", ["spare_catalog_id"], name: "index_spare_catalog_tokens_on_spare_catalog_id", using: :btree

  create_table "spare_catalogs", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "intro"
    t.text     "page"
    t.string   "opt"
    t.integer  "shows"
    t.integer  "spare_catalog_group_id"
  end

  add_index "spare_catalogs", ["spare_catalog_group_id"], name: "index_spare_catalogs_on_spare_catalog_group_id", using: :btree

  create_table "spare_info_phrases", force: :cascade do |t|
    t.integer  "spare_info_id"
    t.string   "catalog_number"
    t.integer  "yandex_campaign_id"
    t.integer  "yandex_banner_id"
    t.datetime "yandex_banner_updated_at"
    t.datetime "yandex_wordstat_updated_at"
    t.integer  "yandex_shows"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "phrase"
    t.boolean  "publish"
    t.integer  "yclicks"
    t.integer  "yshows"
    t.boolean  "primary"
  end

  add_index "spare_info_phrases", ["spare_info_id"], name: "index_spare_info_phrases_on_spare_info_id", using: :btree

  create_table "spare_infos", force: :cascade do |t|
    t.string   "catalog_number"
    t.integer  "brand_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.text     "titles",                        default: [],                 array: true
    t.integer  "min_days"
    t.integer  "min_cost"
    t.integer  "offers"
    t.datetime "aggregated_content_updated_at"
    t.datetime "aggregated_content_checked_at"
    t.boolean  "fix_spare_catalog",             default: false, null: false
  end

  add_index "spare_infos", ["brand_id"], name: "index_spare_infos_on_brand_id", using: :btree
  add_index "spare_infos", ["spare_catalog_id"], name: "index_spare_infos_on_spare_catalog_id", using: :btree

  create_table "spare_replacements", force: :cascade do |t|
    t.integer  "from_spare_info_id"
    t.integer  "to_spare_info_id"
    t.boolean  "wrong"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notes"
    t.text     "notes_invisible"
    t.integer  "status"
  end

  add_index "spare_replacements", ["from_spare_info_id"], name: "index_spare_replacements_on_from_spare_info_id", using: :btree
  add_index "spare_replacements", ["to_spare_info_id"], name: "index_spare_replacements_on_to_spare_info_id", using: :btree

  create_table "tests", force: :cascade do |t|
    t.binary   "binary"
    t.boolean  "boolean"
    t.date     "date"
    t.datetime "datetime"
    t.decimal  "decimal"
    t.float    "float"
    t.integer  "integer"
    t.string   "string"
    t.text     "text"
    t.time     "time"
    t.datetime "timestamp"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                       default: "", null: false
    t.string   "encrypted_password",          default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",               default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.text     "user_agent"
    t.text     "accept_language"
    t.text     "location"
    t.text     "referrer"
    t.text     "first_referrer"
    t.integer  "credit",                      default: 0
    t.integer  "debit",                       default: 0
    t.integer  "role"
    t.string   "name"
    t.string   "phone"
    t.integer  "creator_id"
    t.string   "ipgeobase_name"
    t.string   "ipgeobase_names_depth_cache"
    t.string   "time_zone"
    t.text     "notes"
    t.text     "notes_invisible"
  end

  add_index "users", ["creator_id"], name: "index_users_on_creator_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

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

  add_foreign_key "orders", "deliveries_places"
  add_foreign_key "products", "deliveries_places"
  add_foreign_key "spare_catalogs", "spare_catalog_groups"
  add_foreign_key "spare_info_phrases", "spare_infos"
end
