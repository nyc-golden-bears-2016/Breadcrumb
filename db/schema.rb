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

ActiveRecord::Schema.define(version: 20160811184956) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "crumbs", force: :cascade do |t|
    t.string   "name",                            null: false
    t.text     "description"
    t.string   "media_link_1"
    t.string   "media_link_2"
    t.float    "latitude",                        null: false
    t.float    "longitude",                       null: false
    t.boolean  "requires_answer", default: false
    t.string   "answer"
    t.integer  "trail_id",                        null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "experiences", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "trail_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.integer  "trail_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trails", force: :cascade do |t|
    t.string   "name",                         null: false
    t.text     "description"
    t.string   "media_link_1"
    t.string   "media_link_2"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "private",      default: false
    t.boolean  "sequential",   default: false
    t.boolean  "published",    default: false
    t.integer  "creator_id"
    t.string   "password"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
