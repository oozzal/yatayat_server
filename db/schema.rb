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

ActiveRecord::Schema.define(version: 20150126020102) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["name"], name: "index_categories_on_name", unique: true, using: :btree

  create_table "locations", force: true do |t|
    t.decimal  "latitude",   precision: 10, scale: 6
    t.decimal  "longitude",  precision: 10, scale: 6
    t.string   "city"
    t.string   "address"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reports", force: true do |t|
    t.string   "message"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cached_votes_total",      default: 0
    t.integer  "cached_votes_score",      default: 0
    t.integer  "cached_votes_up",         default: 0
    t.integer  "cached_votes_down",       default: 0
    t.integer  "cached_weighted_score",   default: 0
    t.integer  "cached_weighted_total",   default: 0
    t.float    "cached_weighted_average", default: 0.0
    t.integer  "location_id"
    t.integer  "category_id"
  end

  add_index "reports", ["cached_votes_down"], name: "index_reports_on_cached_votes_down", using: :btree
  add_index "reports", ["cached_votes_score"], name: "index_reports_on_cached_votes_score", using: :btree
  add_index "reports", ["cached_votes_total"], name: "index_reports_on_cached_votes_total", using: :btree
  add_index "reports", ["cached_votes_up"], name: "index_reports_on_cached_votes_up", using: :btree
  add_index "reports", ["cached_weighted_average"], name: "index_reports_on_cached_weighted_average", using: :btree
  add_index "reports", ["cached_weighted_score"], name: "index_reports_on_cached_weighted_score", using: :btree
  add_index "reports", ["cached_weighted_total"], name: "index_reports_on_cached_weighted_total", using: :btree
  add_index "reports", ["user_id"], name: "index_reports_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "phone_number"
    t.string   "sim_serial_number"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cached_votes_total",      default: 0
    t.integer  "cached_votes_score",      default: 0
    t.integer  "cached_votes_up",         default: 0
    t.integer  "cached_votes_down",       default: 0
    t.integer  "cached_weighted_score",   default: 0
    t.integer  "cached_weighted_total",   default: 0
    t.float    "cached_weighted_average", default: 0.0
    t.string   "role"
  end

  add_index "users", ["cached_votes_down"], name: "index_users_on_cached_votes_down", using: :btree
  add_index "users", ["cached_votes_score"], name: "index_users_on_cached_votes_score", using: :btree
  add_index "users", ["cached_votes_total"], name: "index_users_on_cached_votes_total", using: :btree
  add_index "users", ["cached_votes_up"], name: "index_users_on_cached_votes_up", using: :btree
  add_index "users", ["cached_weighted_average"], name: "index_users_on_cached_weighted_average", using: :btree
  add_index "users", ["cached_weighted_score"], name: "index_users_on_cached_weighted_score", using: :btree
  add_index "users", ["cached_weighted_total"], name: "index_users_on_cached_weighted_total", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["phone_number"], name: "index_users_on_phone_number", unique: true, using: :btree
  add_index "users", ["sim_serial_number"], name: "index_users_on_sim_serial_number", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "votes", force: true do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

end
