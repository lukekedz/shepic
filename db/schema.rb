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

ActiveRecord::Schema.define(version: 20180903114426) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.integer  "week_id",        null: false
    t.datetime "date"
    t.string   "away",           null: false
    t.string   "home",           null: false
    t.float    "spread"
    t.string   "location"
    t.string   "start_time"
    t.boolean  "tiebreaker",     null: false
    t.string   "winner"
    t.integer  "away_pts"
    t.integer  "home_pts"
    t.integer  "total_pts"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.boolean  "game_started",   null: false
    t.string   "time_remaining"
    t.boolean  "game_finished"
  end

  create_table "picks", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "game_id",    null: false
    t.string   "pick"
    t.string   "away_home"
    t.integer  "tbreak_pts"
    t.boolean  "correct"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "standings", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "wins"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "username"
    t.boolean  "admin",                  default: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "weeks", force: :cascade do |t|
    t.integer  "week",                       null: false
    t.boolean  "locked",     default: false
    t.boolean  "finalized",  default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

end
