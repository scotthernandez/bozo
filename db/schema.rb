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

ActiveRecord::Schema.define(:version => 20110124223456) do

  create_table "articles", :force => true do |t|
    t.string   "thread",        :limit => 40
    t.string   "url",           :limit => 40
    t.string   "author",        :limit => 80
    t.integer  "replies"
    t.integer  "authors"
    t.datetime "link_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subject",       :limit => 140
    t.integer  "user_id"
    t.integer  "category_id"
    t.integer  "status_id"
    t.datetime "date_assigned"
    t.datetime "date_closed"
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
    t.string   "email",                               :default => "",    :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",    :null => false
    t.string   "password_salt",                       :default => "",    :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "gmail",                               :default => false
    t.boolean  "sms",                                 :default => false
    t.boolean  "weekend",                             :default => false
    t.string   "estime",               :limit => 5
    t.string   "eetime",               :limit => 5
    t.string   "sstime",               :limit => 5
    t.string   "setime",               :limit => 5
    t.string   "nick",                 :limit => 12
    t.string   "sms_address",          :limit => 30
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
