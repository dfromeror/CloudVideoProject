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

ActiveRecord::Schema.define(version: 20150916022938) do

  create_table "clients", force: true do |t|
    t.string   "name",       null: false
    t.string   "email",      null: false
    t.string   "layout"
    t.string   "logo",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contests", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.string   "media"
    t.string   "url"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "award_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name", null: false
    t.string   "last_name"
    t.string   "email",      null: false
    t.string   "password",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "client_id"
  end

  create_table "video_statuses", force: true do |t|
    t.string   "name"
    t.integer  "order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "uploads", force: true do |t|
    t.string   "original_name"
    t.string   "converted_name"
    t.string   "original_format"
    t.string   "original_path"
    t.string   "converted_path"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.text     "message"
    t.decimal  "size",            precision: 10, scale: 0
    t.datetime "conversion_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contest_id"
    t.integer  "video_status_id"
  end

end
