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

ActiveRecord::Schema.define(version: 20160329021110) do

  create_table "comment_events", force: :cascade do |t|
    t.integer  "issue"
    t.string   "organization"
    t.string   "repository"
    t.text     "body"
    t.string   "actor"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "issue_events", force: :cascade do |t|
    t.string   "action"
    t.string   "name"
    t.string   "actor"
    t.string   "repository"
    t.string   "organization"
    t.integer  "number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "mention_events", force: :cascade do |t|
    t.string   "mentioned_id"
    t.integer  "slack_message_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "mention_events", ["slack_message_id"], name: "index_mention_events_on_slack_message_id"

  create_table "pull_request_events", force: :cascade do |t|
    t.string   "action"
    t.string   "name"
    t.string   "actor"
    t.string   "repository"
    t.string   "organization"
    t.integer  "number"
    t.string   "from"
    t.string   "to"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "slack_id_to_names", force: :cascade do |t|
    t.string   "slack_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "slack_messages", force: :cascade do |t|
    t.string   "channel_id"
    t.string   "team_id"
    t.text     "body"
    t.string   "actor"
    t.boolean  "shared_link"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "slack_settings", force: :cascade do |t|
    t.string   "bot_access_token"
    t.string   "bot_user_id"
    t.string   "team_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "wiki_events", force: :cascade do |t|
    t.string   "organization"
    t.string   "repository"
    t.string   "actor"
    t.text     "pages"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
