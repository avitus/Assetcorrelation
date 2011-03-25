class CreatePortfolios < ActiveRecord::Migration
  def self.up
    create_table :portfolios do |t|
      t.string    :username
      t.string    :tickers
      t.integer   :period
      t.decimal   :std_dev,    :precision =>  5, :scale => 2, :default =>  0.0
      t.decimal   :intra_corr, :precision =>  5, :scale => 2, :default =>  0.0
      t.decimal   :port_ret,   :precision =>  7, :scale => 2, :default =>  0.0      
      t.timestamps
    end
  end

  def self.down
    drop_table :portfolios
  end
end
