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

ActiveRecord::Schema.define(version: 20140714214242) do

  create_table "brands", force: true do |t|
    t.string   "name"
    t.string   "brand_country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inventories", force: true do |t|
    t.integer  "item_id"
    t.integer  "box",                          null: false
    t.integer  "quantity"
    t.boolean  "is_latest_version",            null: false
    t.string   "start_date",        limit: 16
    t.string   "end_date",          limit: 16
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", force: true do |t|
    t.string   "name"
    t.string   "item_code",  limit: 32, null: false
    t.string   "type_id"
    t.integer  "brand_id"
    t.float    "price",                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.string   "order_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "records", force: true do |t|
    t.integer  "item_id"
    t.integer  "box",                                 null: false
    t.integer  "quantity"
    t.float    "price",                 default: 0.0, null: false
    t.string   "date",       limit: 15,               null: false
    t.integer  "buy_sell",   limit: 1,                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_id"
    t.integer  "staff_id"
  end

  create_table "regions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "staffs", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.integer  "auth_level", limit: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["id"], name: "id", unique: true, using: :btree

end
