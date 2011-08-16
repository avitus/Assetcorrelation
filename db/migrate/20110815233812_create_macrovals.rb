class CreateMacrovals < ActiveRecord::Migration
  def change
    create_table :macrovals do |t|
      t.decimal :year_month, 				:precision => 10, :scale => 2, :null => false
      t.decimal :spcomposite, 			:precision => 10, :scale => 2
      t.decimal :dividends, 				:precision => 10, :scale => 2
      t.decimal :earnings, 					:precision => 10, :scale => 2
      t.decimal :cpi, 							:precision => 10, :scale => 2
      t.decimal :date_fraction, 		:precision => 10, :scale => 2
      t.decimal :ten_year_rate, 		:precision => 10, :scale => 2
      t.decimal :price_real, 				:precision => 10, :scale => 2
      t.decimal :dividends_real, 		:precision => 10, :scale => 2
      t.decimal :earnings_real, 		:precision => 10, :scale => 2
      t.decimal :pe_tenyear, 				:precision => 10, :scale => 2
      t.decimal :monthly_return, 		:precision => 10, :scale => 2
      t.decimal :one_year_return, 	:precision => 10, :scale => 2
      t.decimal :three_year_return, :precision => 10, :scale => 2
      t.decimal :equity_risk_yield, :precision => 10, :scale => 2
      t.decimal :dividend_yield, 		:precision => 10, :scale => 2
      t.decimal :earnings_yield, 		:precision => 10, :scale => 2
      t.decimal :inflation, 				:precision => 10, :scale => 2

      t.timestamps
    end
    
    add_index :macrovals, :year_month, :unique => true
    
  end
end
