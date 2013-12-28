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

ActiveRecord::Schema.define(version: 20131228074119) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clicks", force: true do |t|
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "post_id"
  end

  add_index "clicks", ["post_id"], name: "index_clicks_on_post_id", using: :btree

  create_table "posts", force: true do |t|
    t.text     "title"
    t.text     "description"
    t.text     "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "thumb"
    t.boolean  "remove_thumb"
    t.string   "thumb_cache"
    t.integer  "site_id"
    t.datetime "posted_at"
  end

  add_index "posts", ["site_id"], name: "index_posts_on_site_id", using: :btree

  create_table "sites", force: true do |t|
    t.text     "name"
    t.text     "url"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "rss"
    t.integer  "category_id"
  end

  add_index "sites", ["category_id"], name: "index_sites_on_category_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "screen_name"
    t.text     "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
