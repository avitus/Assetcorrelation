class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :name
      t.string :ticker
      t.string :asset_class

      t.timestamps
    end
    
    add_index :assets, :name,       :unique => true
    add_index :assets, :ticker,     :unique => true
    add_index :assets, :asset_class
            
  end
end
