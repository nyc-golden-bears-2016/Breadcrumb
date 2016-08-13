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

ActiveRecord::Schema.define(version: 20160812041345) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actives", force: :cascade do |t|
    t.integer  "user_id",                            null: false
    t.integer  "trail_id",                           null: false
    t.boolean  "completed",          default: false
    t.integer  "last_crumb_reached", default: 0
    t.boolean  "winner",             default: false
    t.string   "entered_password"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "crumbs", force: :cascade do |t|
    t.string   "name",                            null: false
    t.text     "description"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "requires_answer", default: false
    t.string   "answer"
    t.integer  "trail_id",                        null: false
    t.integer  "order_number"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.integer  "trail_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.string   "name"
    t.string   "avatar"
    t.string   "imageable_type"
    t.integer  "imageable_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["imageable_type", "imageable_id"], name: "index_images_on_imageable_type_and_imageable_id", using: :btree
  end

  create_table "sounds", force: :cascade do |t|
    t.integer  "crumb_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string   "subject",    limit: 25
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "tags_trails", force: :cascade do |t|
    t.integer  "trail_id",   null: false
    t.integer  "tag_id",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trails", force: :cascade do |t|
    t.string   "name",                        null: false
    t.text     "description"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "priv",        default: false
    t.boolean  "sequential",  default: false
    t.boolean  "published",   default: false
    t.integer  "creator_id"
    t.string   "password"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
