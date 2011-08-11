class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.integer :asset_id
      t.decimal :holding_percentage

      t.timestamps
    end
    
    add_index :positions, :asset_id
        
  end
end
