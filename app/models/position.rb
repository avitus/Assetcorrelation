class Position < ActiveRecord::Base
	has_one :asset
	
	# accepts_nested_attributes_for :asset
	
	attr_accessible :asset_id, :holding_percentage #, :asset_attributes
	
end
