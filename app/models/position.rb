class Position < ActiveRecord::Base
	belongs_to :security

	attr_accessible :security_id, :shares, :holding_percentage, :ticker
  accepts_nested_attributes_for :security

end
