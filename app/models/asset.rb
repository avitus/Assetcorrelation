class Asset < ActiveRecord::Base
	
	has_many		:price_quotes
	belongs_to  :position
	
end
