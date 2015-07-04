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

ActiveRecord::Schema.define(version: 20150627114948) do

  create_table "channels", force: :cascade do |t|
    t.string   "xmltv_id",          limit: 255
    t.string   "free_or_pay",       limit: 255
    t.string   "name",              limit: 255
    t.string   "short_name",        limit: 255
    t.boolean  "black_flag",        limit: 1
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "url_friendly_name", limit: 255
  end

  create_table "conversion_summaries", force: :cascade do |t|
    t.integer  "raw_channel_count",       limit: 4
    t.integer  "final_raw_channel_count", limit: 4
    t.integer  "starting_channel_count",  limit: 4
    t.integer  "channels_created",        limit: 4
    t.integer  "channels_skipped",        limit: 4
    t.integer  "final_channel_count",     limit: 4
    t.integer  "raw_program_count",       limit: 4
    t.integer  "final_raw_program_count", limit: 4
    t.integer  "starting_program_count",  limit: 4
    t.integer  "programs_created",        limit: 4
    t.integer  "programs_skipped",        limit: 4
    t.integer  "final_program_count",     limit: 4
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.boolean  "conversion_completed",    limit: 1
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "programs", force: :cascade do |t|
    t.string   "title",                 limit: 255
    t.string   "subtitle",              limit: 255
    t.string   "category",              limit: 255
    t.string   "description",           limit: 255
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.integer  "region_id",             limit: 4
    t.integer  "channel_id",            limit: 4
    t.integer  "sport_id",              limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "url_friendly_category", limit: 255
  end

  add_index "programs", ["channel_id"], name: "index_programs_on_channel_id", using: :btree
  add_index "programs", ["region_id"], name: "index_programs_on_region_id", using: :btree
  add_index "programs", ["sport_id"], name: "index_programs_on_sport_id", using: :btree

  create_table "raw_channels", force: :cascade do |t|
    t.string   "xmltv_id",     limit: 255
    t.string   "channel_name", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "raw_programs", force: :cascade do |t|
    t.string   "title",            limit: 255
    t.string   "subtitle",         limit: 255
    t.string   "category",         limit: 255
    t.string   "description",      limit: 255
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.string   "region_name",      limit: 255
    t.string   "channel_xmltv_id", limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "regions", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.integer  "timezone_adjustment", limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "url_friendly_name",   limit: 255
  end

  create_table "sports", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "url_friendly_name", limit: 255
  end

end
