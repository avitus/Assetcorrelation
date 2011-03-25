class AddPrecisionToReturns < ActiveRecord::Migration
  def self.up
    change_column :portfolios, :port_ret, :decimal, :precision => 8, :scale => 2, :default =>  0.0
  end

  def self.down
    change_column :portfolios, :port_ret, :decimal, :precision => 5, :scale => 2, :default =>  0.0
  end
end