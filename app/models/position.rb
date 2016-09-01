class Position < ActiveRecord::Base

  belongs_to :security

  attr_accessible :security, :securities_attributes, :shares, :holding_percentage, :ticker, :portfolio_id, :security_id
  
  accepts_nested_attributes_for :security


end
