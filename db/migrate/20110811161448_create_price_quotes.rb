class CreatePriceQuotes < ActiveRecord::Migration
  def change
    create_table :price_quotes do |t|
      t.integer :asset_id
      t.date    :date
      t.decimal :price, :precision => 10, :scale => 2
      t.decimal :daily_return, :precision => 10, :scale => 2

      t.timestamps
    end
    
    add_index :price_quotes, :asset_id    
    add_index :price_quotes, :date
    
  end
end
