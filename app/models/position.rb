class Position < ActiveRecord::Base
	belongs_to :asset
		
	attr_accessible :asset_id, :holding_percentage
	
end
