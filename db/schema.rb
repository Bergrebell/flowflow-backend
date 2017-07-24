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

ActiveRecord::Schema.define(version: 20170717151554) do

  create_table "measurements", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "quantity"
    t.integer  "maximum_quantity"
    t.datetime "reading_time"
    t.integer  "station_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["station_id"], name: "index_measurements_on_station_id", using: :btree
  end

  create_table "stations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "station_id"
    t.string   "name"
    t.integer  "water_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["water_id"], name: "index_stations_on_water_id", using: :btree
  end

end
