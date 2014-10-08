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

ActiveRecord::Schema.define(version: 20141008090149) do

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "frequent_words", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "links", force: true do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "site_from_id"
    t.integer  "site_to_id"
    t.text     "sitename_from"
    t.text     "sitename_to"
    t.boolean  "scanned",       default: false
  end

  add_index "links", ["site_from_id"], name: "index_links_on_site_from_id", using: :btree
  add_index "links", ["site_to_id"], name: "index_links_on_site_to_id", using: :btree

  create_table "reqs", force: true do |t|
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",     default: "unprocessed"
    t.integer  "user_id"
    t.boolean  "manual",     default: true
  end

  add_index "reqs", ["user_id"], name: "index_reqs_on_user_id", using: :btree

  create_table "site_links", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "site_users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "site_id"
    t.integer  "user_id"
  end

  add_index "site_users", ["site_id"], name: "index_site_users_on_site_id", using: :btree
  add_index "site_users", ["user_id"], name: "index_site_users_on_user_id", using: :btree

  create_table "site_words", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "site_id"
    t.integer  "word_id"
    t.integer  "sites_count", default: 0
  end

  add_index "site_words", ["site_id"], name: "index_site_words_on_site_id", using: :btree
  add_index "site_words", ["word_id"], name: "index_site_words_on_word_id", using: :btree

  create_table "sites", force: true do |t|
    t.string   "name"
    t.text     "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rank",        default: 0
    t.string   "icon"
  end

  create_table "users", force: true do |t|
    t.string   "crypted_password",          limit: 40
    t.string   "salt",                      limit: 40
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "name"
    t.string   "email_address"
    t.boolean  "administrator",                        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",                                default: "active"
    t.datetime "key_timestamp"
  end

  add_index "users", ["state"], name: "index_users_on_state", using: :btree

  create_table "word_users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "word_id"
    t.integer  "user_id"
    t.integer  "parrent_word_id"
  end

  add_index "word_users", ["parrent_word_id"], name: "index_word_users_on_parrent_word_id", using: :btree
  add_index "word_users", ["user_id"], name: "index_word_users_on_user_id", using: :btree
  add_index "word_users", ["word_id"], name: "index_word_users_on_word_id", using: :btree

  create_table "words", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rank",          default: 0
    t.integer  "word_id"
    t.integer  "words_counter", default: 0
    t.integer  "sites_count",   default: 0
  end

  add_index "words", ["word_id"], name: "index_words_on_word_id", using: :btree

end
