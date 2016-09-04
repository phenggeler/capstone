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

ActiveRecord::Schema.define(version: 20160903211224) do

  create_table "authors", force: :cascade do |t|
    t.string   "username"
    t.string   "email",            null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "verified"
    t.index ["email"], name: "index_authors_on_email", unique: true
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
  end

  create_table "signups", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "password"
    t.string   "password_confirmation"
  end

  create_table "watchers", force: :cascade do |t|
    t.string   "domain"
    t.text     "source"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "email"
    t.string   "title"
    t.string   "p"
    t.string   "h1"
    t.string   "h2"
    t.string   "h3"
    t.integer  "link"
    t.string   "description"
    t.string   "keywords"
    t.string   "linktext"
    t.string   "use"
  end

end
