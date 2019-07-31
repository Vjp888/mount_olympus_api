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

ActiveRecord::Schema.define(version: 2019_07_30_174222) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string "games"
    t.string "event_name"
    t.string "sport"
  end

  create_table "olympian_events", force: :cascade do |t|
    t.bigint "olympian_id"
    t.bigint "event_id"
    t.string "medal"
    t.index ["event_id"], name: "index_olympian_events_on_event_id"
    t.index ["olympian_id"], name: "index_olympian_events_on_olympian_id"
  end

  create_table "olympians", force: :cascade do |t|
    t.string "name"
    t.string "sex"
    t.integer "age"
    t.integer "height"
    t.integer "weight"
    t.string "sport"
    t.string "team"
  end

  add_foreign_key "olympian_events", "events"
  add_foreign_key "olympian_events", "olympians"
end
