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

ActiveRecord::Schema.define(version: 20150910104117) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "citext"
  enable_extension "uuid-ossp"

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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "block",      default: false
  end

  create_table "brands", force: :cascade do |t|
    t.citext   "name"
    t.integer  "brand_id"
    t.string   "cached_brand"
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

  create_table "cars", force: :cascade do |t|
    t.integer  "god"
    t.string   "period"
    t.integer  "brand_id"
    t.string   "cached_brand"
    t.integer  "model_id"
    t.string   "cached_model"
    t.integer  "generation_id"
    t.string   "cached_generation"
    t.integer  "modification_id"
    t.string   "cached_modification"
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
    t.integer  "user_id"
  end

  add_index "cars", ["brand_id"], name: "index_cars_on_brand_id", using: :btree
  add_index "cars", ["generation_id"], name: "index_cars_on_generation_id", using: :btree
  add_index "cars", ["model_id"], name: "index_cars_on_model_id", using: :btree
  add_index "cars", ["modification_id"], name: "index_cars_on_modification_id", using: :btree
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

  create_table "deliveries_options", force: :cascade do |t|
    t.string   "name"
    t.boolean  "full_prepayment_required"
    t.boolean  "postal_address_required"
    t.boolean  "passport_required"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deliveries_places", force: :cascade do |t|
    t.string   "name"
    t.text     "content"
    t.text     "vertices"
    t.string   "active_fill_color"
    t.string   "active_fill_opacity"
    t.string   "active_stroke_color"
    t.string   "active_stroke_opacity"
    t.string   "active_stroke_weight"
    t.string   "inactive_fill_color"
    t.string   "inactive_fill_opacity"
    t.string   "inactive_stroke_color"
    t.string   "inactive_stroke_opacity"
    t.string   "inactive_stroke_weight"
    t.boolean  "realize",                 default: true
    t.boolean  "active",                  default: true
    t.float    "lat"
    t.float    "lng"
    t.integer  "zoom"
    t.integer  "z_index"
    t.boolean  "display_marker"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "phone3"
    t.string   "phone4"
    t.string   "phone5"
    t.string   "postal_address"
    t.string   "image1"
    t.string   "image2"
    t.string   "image3"
    t.string   "address_locality"
    t.string   "postal_code"
    t.string   "street_address"
    t.string   "email1"
    t.string   "email2"
    t.string   "email3"
    t.string   "image4"
    t.string   "image5"
    t.string   "price_url"
    t.string   "metro"
    t.boolean  "partner",                 default: false, null: false
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

  create_table "emails", force: :cascade do |t|
    t.string   "value"
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "confirmed"
    t.datetime "confirmation_datetime"
    t.string   "confirmation_token"
  end

  add_index "emails", ["profile_id"], name: "index_emails_on_profile_id", using: :btree

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
    t.string   "cached_brand"
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

  create_table "names", force: :cascade do |t|
    t.string   "surname"
    t.string   "name"
    t.string   "patronymic"
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "names", ["profile_id"], name: "index_names_on_profile_id", using: :btree

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
    t.integer  "user_id"
  end

  add_index "orders", ["company_id"], name: "index_orders_on_company_id", using: :btree
  add_index "orders", ["delivery_option_id"], name: "index_orders_on_delivery_option_id", using: :btree
  add_index "orders", ["delivery_place_id"], name: "index_orders_on_delivery_place_id", using: :btree
  add_index "orders", ["delivery_variant_id"], name: "index_orders_on_delivery_variant_id", using: :btree
  add_index "orders", ["postal_address_id"], name: "index_orders_on_postal_address_id", using: :btree
  add_index "orders", ["profile_id"], name: "index_orders_on_profile_id", using: :btree
  add_index "orders", ["token"], name: "index_orders_on_token", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

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
  end

  add_index "passports", ["profile_id"], name: "index_passports_on_profile_id", using: :btree

  create_table "phones", force: :cascade do |t|
    t.string   "value"
    t.boolean  "mobile"
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "confirmed"
    t.datetime "confirmation_datetime"
    t.string   "confirmation_token"
  end

  add_index "phones", ["profile_id"], name: "index_phones_on_profile_id", using: :btree

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
    t.integer  "user_id"
  end

  add_index "postal_addresses", ["user_id"], name: "index_postal_addresses_on_user_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "catalog_number"
    t.integer  "brand_id"
    t.string   "cached_brand"
    t.string   "cached_order"
    t.string   "short_name"
    t.text     "long_name"
    t.integer  "quantity_ordered"
    t.integer  "quantity_available"
    t.integer  "min_days"
    t.integer  "max_days"
    t.decimal  "buy_cost",            precision: 8, scale: 2
    t.decimal  "sell_cost",           precision: 8, scale: 2
    t.boolean  "hide_catalog_number",                         default: false
    t.string   "status"
    t.integer  "probability"
    t.integer  "product_id"
    t.integer  "order_id"
    t.integer  "supplier_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "products", ["order_id"], name: "index_products_on_order_id", using: :btree
  add_index "products", ["product_id"], name: "index_products_on_product_id", using: :btree
  add_index "products", ["supplier_id"], name: "index_products_on_supplier_id", using: :btree
  add_index "products", ["user_id"], name: "index_products_on_user_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.text     "cached_names"
    t.text     "cached_phones"
    t.text     "cached_emails"
    t.text     "cached_passports"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.string   "name"
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
    t.string   "ipgeobase_name"
    t.string   "ipgeobase_names_depth_cache"
    t.string   "time_zone"
    t.text     "notes"
    t.text     "notes_invisible"
  end

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

  add_foreign_key "spare_catalogs", "spare_catalog_groups"
  add_foreign_key "spare_info_phrases", "spare_infos"
end
