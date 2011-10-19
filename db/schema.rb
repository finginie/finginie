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

ActiveRecord::Schema.define(:version => 20111019102014) do

  create_table "active_admin_comments", :force => true do |t|
    t.integer  "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "clearance_omniauth_authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clearance_omniauth_authentications", ["user_id"], :name => "index_clearance_omniauth_authentications_on_user_id"

  create_table "net_positions", :force => true do |t|
    t.integer  "portfolio_id"
    t.integer  "security_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "net_positions", ["portfolio_id"], :name => "index_net_positions_on_portfolio_id"
  add_index "net_positions", ["security_id"], :name => "index_net_positions_on_security_id"

  create_table "portfolios", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "portfolios", ["user_id"], :name => "index_portfolios_on_user_id"

  create_table "securities", :force => true do |t|
    t.string   "type"
    t.string   "name"
    t.integer  "user_id"
    t.decimal  "current_price"
    t.decimal  "period"
    t.decimal  "rate_of_interest"
    t.text     "location"
    t.decimal  "emi"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "securities", ["user_id"], :name => "index_securities_on_user_id"

  create_table "transactions", :force => true do |t|
    t.integer  "net_position_id"
    t.decimal  "price"
    t.date     "date"
    t.integer  "quantity"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "transactions", ["net_position_id"], :name => "index_transactions_on_net_position_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "encrypted_password",     :limit => 128
    t.string   "salt",                   :limit => 128
    t.string   "confirmation_token",     :limit => 128
    t.string   "remember_token",         :limit => 128
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
