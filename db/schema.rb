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

ActiveRecord::Schema.define(:version => 20120828070419) do

  create_table "choices", :force => true do |t|
    t.decimal  "score"
    t.text     "text"
    t.decimal  "ceiling"
    t.integer  "question_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "choices", ["question_id"], :name => "index_choices_on_question_id"

  create_table "completed_steps", :force => true do |t|
    t.integer "user_id"
    t.hstore  "meta_data"
    t.string  "step"
  end

  create_table "comprehensive_risk_profilers", :force => true do |t|
    t.integer  "user_id"
    t.decimal  "age"
    t.decimal  "household_savings"
    t.decimal  "household_income"
    t.integer  "dependent"
    t.decimal  "household_expenditure"
    t.decimal  "special_goals_amount"
    t.decimal  "special_goals_years"
    t.decimal  "tax_saving_investment"
    t.integer  "preference"
    t.integer  "portfolio_investment"
    t.decimal  "time_horizon"
    t.decimal  "score_cache"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "comprehensive_risk_profilers", ["user_id"], :name => "index_comprehensive_risk_profilers_on_user_id"

  create_table "events", :force => true do |t|
    t.integer  "user_id"
    t.integer  "target_id"
    t.string   "target_type"
    t.string   "action"
    t.hstore   "data"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "events", ["action"], :name => "index_events_on_action"
  add_index "events", ["data"], :name => "events_data"
  add_index "events", ["target_id"], :name => "index_events_on_target_id"
  add_index "events", ["target_type"], :name => "index_events_on_target_type"
  add_index "events", ["user_id"], :name => "index_events_on_user_id"

  create_table "fixed_deposit_transactions", :force => true do |t|
    t.decimal  "price"
    t.date     "date"
    t.text     "comments"
    t.integer  "portfolio_id"
    t.integer  "fixed_deposit_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "action"
  end

  add_index "fixed_deposit_transactions", ["fixed_deposit_id"], :name => "index_fixed_deposit_transactions_on_fixed_deposit_id"
  add_index "fixed_deposit_transactions", ["portfolio_id"], :name => "index_fixed_deposit_transactions_on_portfolio_id"

  create_table "gold_transactions", :force => true do |t|
    t.decimal  "price"
    t.date     "date"
    t.integer  "quantity"
    t.text     "comments"
    t.integer  "portfolio_id"
    t.integer  "gold_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "action"
  end

  add_index "gold_transactions", ["gold_id"], :name => "index_gold_transactions_on_gold_id"
  add_index "gold_transactions", ["portfolio_id"], :name => "index_gold_transactions_on_portfolio_id"

  create_table "loan_transactions", :force => true do |t|
    t.decimal  "price"
    t.date     "date"
    t.text     "comments"
    t.integer  "portfolio_id"
    t.integer  "loan_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "action"
  end

  add_index "loan_transactions", ["loan_id"], :name => "index_loan_transactions_on_loan_id"
  add_index "loan_transactions", ["portfolio_id"], :name => "index_loan_transactions_on_portfolio_id"

  create_table "mutual_fund_transactions", :force => true do |t|
    t.decimal  "price"
    t.date     "date"
    t.integer  "quantity"
    t.text     "comments"
    t.integer  "portfolio_id"
    t.integer  "mutual_fund_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "action"
  end

  add_index "mutual_fund_transactions", ["mutual_fund_id"], :name => "index_mutual_fund_transactions_on_mutual_fund_id"
  add_index "mutual_fund_transactions", ["portfolio_id"], :name => "index_mutual_fund_transactions_on_portfolio_id"

  create_table "net_positions", :force => true do |t|
    t.integer  "portfolio_id"
    t.integer  "security_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "net_positions", ["portfolio_id"], :name => "index_net_positions_on_portfolio_id"
  add_index "net_positions", ["security_id"], :name => "index_net_positions_on_security_id"

  create_table "portfolios", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "is_public",  :default => false
  end

  add_index "portfolios", ["user_id"], :name => "index_portfolios_on_user_id"

  create_table "questions", :force => true do |t|
    t.decimal  "weight"
    t.text     "text"
    t.integer  "quiz_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.text     "news"
    t.text     "reason"
    t.integer  "correct_choice_id"
  end

  add_index "questions", ["quiz_id"], :name => "index_questions_on_quiz_id"

  create_table "quizzes", :force => true do |t|
    t.string   "result_type"
    t.string   "name"
    t.decimal  "weight"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "slug"
    t.string   "buckets"
  end

  create_table "real_estate_transactions", :force => true do |t|
    t.decimal  "price"
    t.date     "date"
    t.text     "comments"
    t.integer  "portfolio_id"
    t.integer  "real_estate_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "action"
  end

  add_index "real_estate_transactions", ["portfolio_id"], :name => "index_real_estate_transactions_on_portfolio_id"
  add_index "real_estate_transactions", ["real_estate_id"], :name => "index_real_estate_transactions_on_real_estate_id"

  create_table "research_reports", :force => true do |t|
    t.date     "date"
    t.string   "source"
    t.string   "name"
    t.string   "company_name"
    t.string   "sector"
    t.string   "nse_code"
    t.string   "bse_code"
    t.string   "link_url"
    t.string   "recommendation"
    t.decimal  "current_market_price"
    t.decimal  "target_price"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "responses", :force => true do |t|
    t.integer  "risk_profiler_id"
    t.integer  "choice_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "responses", ["choice_id"], :name => "index_responses_on_choice_id"
  add_index "responses", ["risk_profiler_id"], :name => "index_responses_on_risk_profiler_id"

  create_table "securities", :force => true do |t|
    t.string   "type"
    t.string   "name"
    t.integer  "user_id"
    t.decimal  "current_price"
    t.decimal  "period"
    t.decimal  "rate_of_interest"
    t.text     "location"
    t.decimal  "emi"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "sector"
    t.decimal  "beta"
    t.integer  "pe"
    t.integer  "eps"
    t.decimal  "last_close_price"
    t.decimal  "day_change"
    t.decimal  "day_open_price"
    t.string   "symbol"
    t.string   "asset_class"
    t.decimal  "fifty_two_week_high_price"
    t.decimal  "fifty_two_week_low_price"
    t.date     "fifty_two_week_high_date"
    t.date     "fifty_two_week_low_date"
    t.decimal  "rate_of_redemption"
  end

  add_index "securities", ["user_id"], :name => "index_securities_on_user_id"

  create_table "stock_transactions", :force => true do |t|
    t.integer  "quantity"
    t.decimal  "price"
    t.date     "date"
    t.text     "comments"
    t.integer  "portfolio_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "action"
    t.string   "company_code"
  end

  add_index "stock_transactions", ["portfolio_id"], :name => "index_stock_transactions_on_portfolio_id"

  create_table "subscriptions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "subscribable_id"
    t.string   "subscribable_type"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "subscriptions", ["subscribable_id"], :name => "index_subscriptions_on_subscribable_id"
  add_index "subscriptions", ["user_id"], :name => "index_subscriptions_on_user_id"

  create_table "trade_accounts", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "phone_number"
    t.text     "address"
    t.string   "city"
    t.text     "special_requirements"
    t.boolean  "issued"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "trade_accounts", ["user_id"], :name => "index_trade_accounts_on_user_id"

  create_table "transactions", :force => true do |t|
    t.integer  "net_position_id"
    t.decimal  "price"
    t.date     "date"
    t.integer  "quantity"
    t.text     "comments"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "transactions", ["net_position_id"], :name => "index_transactions_on_net_position_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
    t.string   "avatar_url"
    t.string   "location"
    t.string   "occupation"
    t.string   "company"
  end

  add_index "users", ["email"], :name => "index_users_on_email"

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
