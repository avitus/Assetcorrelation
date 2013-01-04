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

ActiveRecord::Schema.define(:version => 20120810000922) do

  create_table "macrovals", :force => true do |t|
    t.decimal  "year_month",        :precision => 10, :scale => 2, :null => false
    t.decimal  "spcomposite",       :precision => 10, :scale => 2
    t.decimal  "dividends",         :precision => 10, :scale => 2
    t.decimal  "earnings",          :precision => 10, :scale => 2
    t.decimal  "cpi",               :precision => 10, :scale => 2
    t.decimal  "date_fraction",     :precision => 10, :scale => 2
    t.decimal  "ten_year_rate",     :precision => 10, :scale => 2
    t.decimal  "price_real",        :precision => 10, :scale => 2
    t.decimal  "dividends_real",    :precision => 10, :scale => 2
    t.decimal  "earnings_real",     :precision => 10, :scale => 2
    t.decimal  "pe_tenyear",        :precision => 10, :scale => 2
    t.decimal  "monthly_return",    :precision => 10, :scale => 2
    t.decimal  "one_year_return",   :precision => 10, :scale => 2
    t.decimal  "three_year_return", :precision => 10, :scale => 2
    t.decimal  "equity_risk_yield", :precision => 10, :scale => 2
    t.decimal  "dividend_yield",    :precision => 10, :scale => 2
    t.decimal  "earnings_yield",    :precision => 10, :scale => 2
    t.decimal  "inflation",         :precision => 10, :scale => 2
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

  add_index "macrovals", ["year_month"], :name => "index_macrovals_on_year_month", :unique => true

  create_table "plans", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "price"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "portfolios", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "portfolios", ["name"], :name => "index_portfolios_on_name"
  add_index "portfolios", ["user_id"], :name => "index_portfolios_on_user_id"

  create_table "positions", :force => true do |t|
    t.integer  "portfolio_id"
    t.integer  "security_id"
    t.integer  "shares"
    t.decimal  "price",              :precision => 10, :scale => 2
    t.decimal  "holding_percentage", :precision => 10, :scale => 2
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
  end

  add_index "positions", ["portfolio_id"], :name => "index_positions_on_portfolio_id"
  add_index "positions", ["security_id"], :name => "index_positions_on_asset_id"

  create_table "price_quotes", :force => true do |t|
    t.integer  "security_id"
    t.date     "date"
    t.decimal  "price",        :precision => 10, :scale => 2
    t.decimal  "daily_return", :precision => 10, :scale => 2
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  add_index "price_quotes", ["date"], :name => "index_price_quotes_on_date"
  add_index "price_quotes", ["security_id"], :name => "index_price_quotes_on_asset_id"

  create_table "rails_admin_histories", :force => true do |t|
    t.string   "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 5
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "securities", :force => true do |t|
    t.string   "name"
    t.string   "ticker"
    t.string   "asset_class"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "securities", ["asset_class"], :name => "index_assets_on_asset_class"
  add_index "securities", ["asset_class"], :name => "index_securities_on_asset_class"
  add_index "securities", ["name"], :name => "index_assets_on_name"
  add_index "securities", ["name"], :name => "index_securities_on_name"
  add_index "securities", ["ticker"], :name => "index_assets_on_ticker", :unique => true
  add_index "securities", ["ticker"], :name => "index_securities_on_ticker", :unique => true

  create_table "subscriptions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "plan_id"
    t.string   "stripe_customer_token"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "name"
    t.boolean  "admin",                  :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
