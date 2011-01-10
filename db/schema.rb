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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110108063732) do

  create_table "articles", :force => true do |t|
    t.string   "thread",      :limit => 40
    t.string   "url",         :limit => 40
    t.string   "author",      :limit => 80
    t.integer  "replies"
    t.integer  "authors"
    t.datetime "link_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subject",     :limit => 140
    t.integer  "user_id"
    t.integer  "category_id"
    t.integer  "status_id"
  end

  create_table "categories", :force => true do |t|
    t.string   "name",       :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statuses", :force => true do |t|
    t.string   "name",       :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name",       :limit => 40
    t.string   "email",      :limit => 40
    t.string   "phone",      :limit => 20
    t.string   "chat",       :limit => 40
    t.boolean  "email_y"
    t.boolean  "phone_y"
    t.boolean  "chat_y"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
