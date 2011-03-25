class AddMacrovalsIndex < ActiveRecord::Migration
  
  def self.up
    create_table :macrovals do |t|
      t.decimal :year_month,     :precision => 10, :scale => 2, :null => false
      t.decimal :spcomposite,    :precision => 10, :scale => 2
      t.decimal :dividends,      :precision => 10, :scale => 2
      t.decimal :earnings,       :precision => 10, :scale => 2
      t.decimal :cpi,            :precision => 10, :scale => 2
      t.decimal :date_fraction,  :precision => 10, :scale => 2
      t.decimal :ten_year_rate,  :precision => 10, :scale => 2
      t.decimal :price_real,     :precision => 10, :scale => 2
      t.decimal :dividends_real, :precision => 10, :scale => 2
      t.decimal :earnings_real,  :precision => 10, :scale => 2
      t.decimal :pe_tenyear,     :precision => 10, :scale => 2
    end
  end

  def self.down
    drop_table :macrovals
  end
end