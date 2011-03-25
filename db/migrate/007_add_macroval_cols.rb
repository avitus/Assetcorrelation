class AddMacrovalCols < ActiveRecord::Migration
  
  def self.up

    add_column :macrovals, :monthly_return,     :decimal, :precision => 10, :scale => 2
    add_column :macrovals, :one_yr_return,      :decimal, :precision => 10, :scale => 2    
    add_column :macrovals, :three_yr_return,    :decimal, :precision => 10, :scale => 2
    add_column :macrovals, :equity_risk_yield,  :decimal, :precision => 10, :scale => 2
    add_column :macrovals, :dividend_yield,     :decimal, :precision => 10, :scale => 2
    add_column :macrovals, :earnings_yield,     :decimal, :precision => 10, :scale => 2    
    add_column :macrovals, :inflation,          :decimal, :precision => 10, :scale => 2      
  end

  def self.down
    remove_column :macrovals, :monthly_return
    remove_column :macrovals, :one_yr_return
    remove_column :macrovals, :three_yr_return    
    remove_column :macrovals, :equity_risk_yield 
    remove_column :macrovals, :dividend_yield 
    remove_column :macrovals, :earnings_yield
    remove_column :macrovals, :inflation
  end
  
end