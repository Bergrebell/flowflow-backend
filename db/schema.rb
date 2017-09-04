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

ActiveRecord::Schema.define(version: 20170904135454) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "measurements", force: :cascade do |t|
    t.datetime "datetime"
    t.float    "value"
    t.integer  "warn_level"
    t.integer  "max_24h"
    t.integer  "warn_level_24h"
    t.string   "type"
    t.integer  "station_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.boolean  "most_recent"
    t.string   "unit"
    t.index ["station_id"], name: "index_measurements_on_station_id", using: :btree
  end

  create_table "stations", force: :cascade do |t|
    t.string   "number"
    t.string   "name"
    t.string   "water_body_name"
    t.string   "water_body_type"
    t.integer  "easting"
    t.integer  "northing"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "weather_stations", force: :cascade do |t|
    t.string   "number"
    t.string   "village"
    t.integer  "easting"
    t.integer  "northing"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
