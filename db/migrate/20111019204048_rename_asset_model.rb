class RenameAssetModel < ActiveRecord::Migration
  def change
    rename_table  :assets, :securities
    rename_column :positions,    :asset_id, :security_id
    rename_column :price_quotes, :asset_id, :security_id
        
    add_index :securities, :name
    add_index :securities, :ticker,     :unique => true
    add_index :securities, :asset_class  
      
  end
end
