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

ActiveRecord::Schema.define(version: 20171221000758) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "donors", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "donation"
    t.string   "campaign_name"
    t.string   "affiliate"
    t.string   "secure_id"
    t.string   "campaign_slug"
    t.string   "key"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "members", force: :cascade do |t|
    t.string   "email"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.integer  "donor_id"
    t.integer  "member_id"
    t.boolean  "sent_status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "token"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_users_on_uid", unique: true, using: :btree
  end

  create_table "videos", force: :cascade do |t|
    t.string   "link"
    t.string   "title"
    t.string   "uid"
    t.string   "file"
    t.text     "description"
    t.integer  "donor_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["donor_id"], name: "index_videos_on_donor_id", using: :btree
    t.index ["uid"], name: "index_videos_on_uid", using: :btree
  end

  add_foreign_key "videos", "donors"
end
