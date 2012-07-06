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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120706132533) do

  create_table "admins", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "candlesticks", :force => true do |t|
    t.date     "date"
    t.integer  "merchandise_id"
    t.integer  "country_id"
    t.decimal  "high",           :precision => 8, :scale => 3
    t.decimal  "low",            :precision => 8, :scale => 3
    t.decimal  "open",           :precision => 8, :scale => 3
    t.decimal  "close",          :precision => 8, :scale => 3
    t.integer  "volume"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  add_index "candlesticks", ["country_id"], :name => "index_candlesticks_on_country_id"
  add_index "candlesticks", ["merchandise_id", "country_id"], :name => "index_candlesticks_on_merchandise_id_and_country_id"
  add_index "candlesticks", ["merchandise_id"], :name => "index_candlesticks_on_merchandise_id"

  create_table "countries", :force => true do |t|
    t.integer  "erep_country_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "countries", ["erep_country_id"], :name => "index_countries_on_erep_country_id"

  create_table "items", :force => true do |t|
    t.string   "country"
    t.string   "item_type"
    t.string   "item_quality"
    t.text     "data"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "market_posts", :force => true do |t|
    t.integer  "merchandise_id"
    t.integer  "country_id"
    t.integer  "item_id"
    t.string   "provider"
    t.integer  "stock"
    t.decimal  "price",          :precision => 8, :scale => 3
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  add_index "market_posts", ["country_id"], :name => "index_market_posts_on_country_id"
  add_index "market_posts", ["item_id"], :name => "index_market_posts_on_item_id"
  add_index "market_posts", ["merchandise_id"], :name => "index_market_posts_on_merchandise_id"

  create_table "merchandises", :force => true do |t|
    t.integer  "quality"
    t.integer  "erep_item_code"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "merchandises", ["quality", "erep_item_code"], :name => "index_merchandises_on_quality_and_erep_item_code"

  create_table "posts", :force => true do |t|
    t.datetime "record_date"
    t.string   "poster_id"
    t.integer  "stock"
    t.decimal  "price",        :precision => 15, :scale => 5
    t.integer  "item_code"
    t.integer  "item_quality"
    t.integer  "country_id"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
