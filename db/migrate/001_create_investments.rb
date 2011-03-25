class CreateInvestments < ActiveRecord::Migration
  def self.up
    create_table  :investments do |t|
      t.string    :company
      t.string    :partner
      t.decimal   :investment,  :precision => 10, :scale => 0
      t.decimal   :outcome_0,   :precision =>  5, :scale => 2, :default => -1.0
      t.decimal   :outcome_1,   :precision =>  5, :scale => 2, :default => -0.8
      t.decimal   :outcome_2,   :precision =>  5, :scale => 2, :default => -0.5
      t.decimal   :outcome_3,   :precision =>  5, :scale => 2, :default => -0.2
      t.decimal   :outcome_4,   :precision =>  5, :scale => 2, :default =>  0.0
      t.decimal   :outcome_5,   :precision =>  5, :scale => 2, :default =>  0.4
      t.decimal   :outcome_6,   :precision =>  5, :scale => 2, :default =>  0.8
      t.decimal   :outcome_7,   :precision =>  5, :scale => 2, :default =>  1.0
      t.decimal   :outcome_8,   :precision =>  5, :scale => 2, :default =>  3.0
      t.decimal   :outcome_9,   :precision =>  5, :scale => 2, :default =>  6.0      
      t.date      :date_initial
      t.decimal   :reserves,    :precision => 10, :scale => 0
    end
  end

  def self.down
    drop_table :investments
  end
end
