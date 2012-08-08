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

ActiveRecord::Schema.define(:version => 20120808054700) do

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
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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

  create_table "referrals", :force => true do |t|
    t.integer  "referrer_id"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "refinery_blog_categories", :force => true do |t|
    t.string   "title"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "cached_slug"
    t.string   "slug"
  end

  add_index "refinery_blog_categories", ["id"], :name => "index_refinery_blog_categories_on_id"
  add_index "refinery_blog_categories", ["slug"], :name => "index_refinery_blog_categories_on_slug"

  create_table "refinery_blog_categories_blog_posts", :force => true do |t|
    t.integer "blog_category_id"
    t.integer "blog_post_id"
  end

  add_index "refinery_blog_categories_blog_posts", ["blog_category_id", "blog_post_id"], :name => "index_blog_categories_blog_posts_on_bc_and_bp"

  create_table "refinery_blog_comments", :force => true do |t|
    t.integer  "blog_post_id"
    t.boolean  "spam"
    t.string   "name"
    t.string   "email"
    t.text     "body"
    t.string   "state"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "refinery_blog_comments", ["id"], :name => "index_refinery_blog_comments_on_id"

  create_table "refinery_blog_posts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.boolean  "draft"
    t.datetime "published_at"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "user_id"
    t.string   "cached_slug"
    t.string   "custom_url"
    t.text     "custom_teaser"
    t.string   "source_url"
    t.string   "source_url_title"
    t.integer  "access_count",     :default => 0
    t.string   "slug"
  end

  add_index "refinery_blog_posts", ["access_count"], :name => "index_refinery_blog_posts_on_access_count"
  add_index "refinery_blog_posts", ["id"], :name => "index_refinery_blog_posts_on_id"
  add_index "refinery_blog_posts", ["slug"], :name => "index_refinery_blog_posts_on_slug"

  create_table "refinery_images", :force => true do |t|
    t.string   "image_mime_type"
    t.string   "image_name"
    t.integer  "image_size"
    t.integer  "image_width"
    t.integer  "image_height"
    t.string   "image_uid"
    t.string   "image_ext"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "refinery_page_part_translations", :force => true do |t|
    t.integer  "refinery_page_part_id"
    t.string   "locale"
    t.text     "body"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "refinery_page_part_translations", ["locale"], :name => "index_refinery_page_part_translations_on_locale"
  add_index "refinery_page_part_translations", ["refinery_page_part_id"], :name => "index_refinery_page_part_translations_on_refinery_page_part_id"

  create_table "refinery_page_parts", :force => true do |t|
    t.integer  "refinery_page_id"
    t.string   "title"
    t.text     "body"
    t.integer  "position"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "refinery_page_parts", ["id"], :name => "index_refinery_page_parts_on_id"
  add_index "refinery_page_parts", ["refinery_page_id"], :name => "index_refinery_page_parts_on_refinery_page_id"

  create_table "refinery_page_translations", :force => true do |t|
    t.integer  "refinery_page_id"
    t.string   "locale"
    t.string   "title"
    t.string   "custom_slug"
    t.string   "menu_title"
    t.string   "slug"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "refinery_page_translations", ["locale"], :name => "index_refinery_page_translations_on_locale"
  add_index "refinery_page_translations", ["refinery_page_id"], :name => "index_refinery_page_translations_on_refinery_page_id"

  create_table "refinery_pages", :force => true do |t|
    t.integer  "parent_id"
    t.string   "path"
    t.string   "slug"
    t.boolean  "show_in_menu",        :default => true
    t.string   "link_url"
    t.string   "menu_match"
    t.boolean  "deletable",           :default => true
    t.boolean  "draft",               :default => false
    t.boolean  "skip_to_first_child", :default => false
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.string   "view_template"
    t.string   "layout_template"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "refinery_pages", ["depth"], :name => "index_refinery_pages_on_depth"
  add_index "refinery_pages", ["id"], :name => "index_refinery_pages_on_id"
  add_index "refinery_pages", ["lft"], :name => "index_refinery_pages_on_lft"
  add_index "refinery_pages", ["parent_id"], :name => "index_refinery_pages_on_parent_id"
  add_index "refinery_pages", ["rgt"], :name => "index_refinery_pages_on_rgt"

  create_table "refinery_resources", :force => true do |t|
    t.string   "file_mime_type"
    t.string   "file_name"
    t.integer  "file_size"
    t.string   "file_uid"
    t.string   "file_ext"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "refinery_roles", :force => true do |t|
    t.string "title"
  end

  create_table "refinery_roles_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "refinery_roles_users", ["role_id", "user_id"], :name => "index_refinery_roles_users_on_role_id_and_user_id"
  add_index "refinery_roles_users", ["user_id", "role_id"], :name => "index_refinery_roles_users_on_user_id_and_role_id"

  create_table "refinery_settings", :force => true do |t|
    t.string   "name"
    t.text     "value"
    t.boolean  "destroyable",     :default => true
    t.string   "scoping"
    t.boolean  "restricted",      :default => false
    t.string   "form_value_type"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "refinery_settings", ["name"], :name => "index_refinery_settings_on_name"

  create_table "refinery_user_plugins", :force => true do |t|
    t.integer "user_id"
    t.string  "name"
    t.integer "position"
  end

  add_index "refinery_user_plugins", ["name"], :name => "index_refinery_user_plugins_on_name"
  add_index "refinery_user_plugins", ["user_id", "name"], :name => "index_refinery_user_plugins_on_user_id_and_name", :unique => true

  create_table "refinery_users", :force => true do |t|
    t.string   "username",               :null => false
    t.string   "email",                  :null => false
    t.string   "encrypted_password",     :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "sign_in_count"
    t.datetime "remember_created_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "slug"
  end

  add_index "refinery_users", ["id"], :name => "index_refinery_users_on_id"
  add_index "refinery_users", ["slug"], :name => "index_refinery_users_on_slug"

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

  create_table "seo_meta", :force => true do |t|
    t.integer  "seo_meta_id"
    t.string   "seo_meta_type"
    t.string   "browser_title"
    t.string   "meta_keywords"
    t.text     "meta_description"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "seo_meta", ["id"], :name => "index_seo_meta_on_id"
  add_index "seo_meta", ["seo_meta_id", "seo_meta_type"], :name => "index_seo_meta_on_seo_meta_id_and_seo_meta_type"

  create_table "steps", :force => true do |t|
    t.string  "name"
    t.integer "points"
    t.string  "completion_link"
  end

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

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

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
