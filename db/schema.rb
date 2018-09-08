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

ActiveRecord::Schema.define(version: 20170531023209) do

  create_table "broadcast_events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "program_id"
    t.integer  "broadcast_service_id"
    t.text     "broadcast_event_hash",       limit: 65535
    t.bigint   "epoch_scheduled_date"
    t.string   "formatted_local_start_date"
    t.datetime "formatted_scheduled_date"
    t.datetime "formatted_end_date"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.index ["broadcast_service_id"], name: "index_broadcast_events_on_broadcast_service_id", using: :btree
    t.index ["epoch_scheduled_date"], name: "index_broadcast_events_on_epoch_scheduled_date", using: :btree
    t.index ["program_id", "broadcast_service_id", "epoch_scheduled_date"], name: "be custom index", unique: true, using: :btree
    t.index ["program_id"], name: "index_broadcast_events_on_program_id", using: :btree
  end

  create_table "broadcast_services", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "region_id"
    t.integer  "channel_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_id"], name: "index_broadcast_services_on_channel_id", using: :btree
    t.index ["region_id", "channel_id"], name: "index_broadcast_services_on_region_id_and_channel_id", unique: true, using: :btree
    t.index ["region_id"], name: "index_broadcast_services_on_region_id", using: :btree
  end

  create_table "channels", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "channel_hash",            limit: 65535
    t.string   "name"
    t.string   "url_friendly_name"
    t.string   "short_name"
    t.string   "tag"
    t.string   "url_friendly_short_name"
    t.string   "default_sport"
    t.integer  "provider_id"
    t.boolean  "black_flag"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "cleaners", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "requested_by"
    t.boolean  "clean_raw_programs"
    t.boolean  "clean_raw_channels"
    t.boolean  "clean_broadcast_events"
    t.boolean  "clean_historic_broadcast_events"
    t.boolean  "clean_programs"
    t.boolean  "clean_broadcast_services"
    t.boolean  "clean_channels"
    t.integer  "job_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "delayed_jobs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "priority",                 default: 0, null: false
    t.integer  "attempts",                 default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "jobs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "log",          limit: 65535
    t.string   "status"
    t.string   "requested_by"
    t.datetime "requested_at"
    t.datetime "started_at"
    t.datetime "completed_at"
    t.integer  "detail_id"
    t.string   "detail_type"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "keywords", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "value"
    t.string   "url_friendly_value"
    t.integer  "sport_id"
    t.integer  "priority"
    t.boolean  "black_flag"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "migrators", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "target_region_list", limit: 65535
    t.string   "requested_by"
    t.integer  "job_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "programs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.string   "episode_title"
    t.integer  "keyword_id"
    t.integer  "duration"
    t.boolean  "black_flag"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "providers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "url_friendly_name"
    t.string   "service_tier"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "raw_channels", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "channel_hash",  limit: 65535
    t.string   "channel_name"
    t.string   "channel_tag"
    t.string   "region_lookup"
    t.string   "region_name"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "raw_programs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "program_hash",  limit: 65535
    t.string   "channel_tag"
    t.string   "region_lookup"
    t.string   "region_name"
    t.boolean  "placeholder"
    t.string   "title"
    t.string   "event_lookup"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "regions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "time_zone_name"
    t.string   "url_friendly_name"
    t.string   "region_lookup"
    t.boolean  "black_flag"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "scrapers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "target_region_list", limit: 65535
    t.float    "days_to_gather",     limit: 24
    t.string   "requested_by"
    t.integer  "job_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "sports", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "url_friendly_name"
    t.boolean  "black_flag"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.string   "email"
    t.text     "source",     limit: 65535
    t.boolean  "admin"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

end
