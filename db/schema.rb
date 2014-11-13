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

ActiveRecord::Schema.define(version: 20141113141143) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ethnicities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ethnicities_users", id: false, force: true do |t|
    t.integer "ethnicity_id"
    t.integer "user_id"
  end

  create_table "messages", force: true do |t|
    t.integer  "user_id"
    t.integer  "recipient_id"
    t.string   "body",         limit: 200
    t.integer  "status",                   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["recipient_id"], name: "index_messages_on_recipient_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "permissions", force: true do |t|
    t.integer  "user_id"
    t.integer  "target_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status"
  end

  add_index "permissions", ["target_user_id"], name: "index_permissions_on_target_user_id", using: :btree
  add_index "permissions", ["user_id"], name: "index_permissions_on_user_id", using: :btree

  create_table "profile_photos", force: true do |t|
    t.string   "photo_object"
    t.boolean  "primary",      default: true
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "birthdate"
    t.string   "country"
    t.string   "postal_code"
    t.integer  "sex",                    default: 0
    t.integer  "status",                 default: 0
    t.integer  "role"
    t.float    "latitude"
    t.float    "longitude"
    t.text     "self_summary"
    t.integer  "height"
    t.integer  "income"
    t.integer  "num_of_kids"
    t.integer  "body_type"
    t.integer  "smoking"
    t.integer  "drinking"
    t.integer  "religion"
    t.integer  "education"
    t.integer  "work_industry"
    t.integer  "wants_kids"
    t.integer  "relationship_status"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "display_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
