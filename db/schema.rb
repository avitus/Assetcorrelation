# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 7) do

  create_table "assets", :force => true do |t|
    t.string   "ticker"
    t.string   "name"
    t.date     "first_traded"
    t.integer  "avail_history"
    t.decimal  "daily_vol",     :precision => 5, :scale => 2, :default => 0.0
    t.decimal  "daily_ret",     :precision => 6, :scale => 2, :default => 0.0
    t.integer  "port_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "macrovals", :force => true do |t|
    t.decimal "year_month",        :precision => 10, :scale => 2, :null => false
    t.decimal "spcomposite",       :precision => 10, :scale => 2
    t.decimal "dividends",         :precision => 10, :scale => 2
    t.decimal "earnings",          :precision => 10, :scale => 2
    t.decimal "cpi",               :precision => 10, :scale => 2
    t.decimal "date_fraction",     :precision => 10, :scale => 2
    t.decimal "ten_year_rate",     :precision => 10, :scale => 2
    t.decimal "price_real",        :precision => 10, :scale => 2
    t.decimal "dividends_real",    :precision => 10, :scale => 2
    t.decimal "earnings_real",     :precision => 10, :scale => 2
    t.decimal "pe_tenyear",        :precision => 10, :scale => 2
    t.decimal "monthly_return",    :precision => 10, :scale => 2
    t.decimal "one_yr_return",     :precision => 10, :scale => 2
    t.decimal "three_yr_return",   :precision => 10, :scale => 2
    t.decimal "equity_risk_yield", :precision => 10, :scale => 2
    t.decimal "dividend_yield",    :precision => 10, :scale => 2
    t.decimal "earnings_yield",    :precision => 10, :scale => 2
    t.decimal "inflation",         :precision => 10, :scale => 2
  end

  create_table "portfolios", :force => true do |t|
    t.string   "username"
    t.string   "tickers"
    t.integer  "period"
    t.decimal  "std_dev",    :precision => 5, :scale => 2, :default => 0.0
    t.decimal  "intra_corr", :precision => 5, :scale => 2, :default => 0.0
    t.decimal  "port_ret",   :precision => 8, :scale => 2, :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :default => "", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

end
