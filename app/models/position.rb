class Position < ActiveRecord::Base
	belongs_to :asset
		
	attr_accessible :asset_id, :shares, :holding_percentage
	
end
