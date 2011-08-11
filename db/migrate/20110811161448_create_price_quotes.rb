class CreatePriceQuotes < ActiveRecord::Migration
  def change
    create_table :price_quotes do |t|
      t.integer :asset_id
      t.date    :date
      t.decimal :price
      t.decimal :daily_return

      t.timestamps
    end
    
    add_index :price_quotes, :asset_id    
    
  end
end
