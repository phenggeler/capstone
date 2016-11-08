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

ActiveRecord::Schema.define(version: 20161106231623) do

  create_table "authentications", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid"
  end

  create_table "contents", force: :cascade do |t|
    t.string   "domain"
    t.text     "source"
    t.string   "p"
    t.string   "h1"
    t.string   "h2"
    t.string   "h3"
    t.integer  "link"
    t.string   "description"
    t.string   "keywords"
    t.string   "use"
    t.string   "url"
    t.string   "frequency"
    t.integer  "sum"
    t.integer  "watcher_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "title"
    t.string   "linktext"
    t.index ["watcher_id"], name: "index_contents_on_watcher_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
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
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "domains", force: :cascade do |t|
    t.string   "name"
    t.string   "uacode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "pubid"
    t.integer  "user_id"
    t.index ["user_id"], name: "index_domains_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email",            null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "verified"
    t.string   "provider"
    t.string   "uid"
    t.string   "api_auth_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["provider"], name: "index_users_on_provider"
    t.index ["uid"], name: "index_users_on_uid"
  end

  create_table "watchers", force: :cascade do |t|
    t.string   "domain"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "email"
    t.integer  "user_id"
    t.string   "url"
    t.integer  "content_id"
    t.string   "frequency"
    t.datetime "lastscanned"
    t.index ["content_id"], name: "index_watchers_on_content_id"
    t.index ["user_id"], name: "index_watchers_on_user_id"
  end

end
