class AddAssetDataTable < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.string    :ticker
      t.string    :name
      t.date      :first_traded
      t.integer   :avail_history
      t.decimal   :daily_vol, :precision =>  5, :scale => 2, :default =>  0.0     
      t.decimal   :daily_ret, :precision =>  6, :scale => 2, :default =>  0.0        
      t.timestamps
    end
  end

  def self.down
    drop_table :assets
  end
end