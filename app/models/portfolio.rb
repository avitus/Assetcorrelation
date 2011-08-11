class Portfolio < ActiveRecord::Base
	
	has_many		:positions
	has_many    :assets, :through => :positions
	belongs_to	:user
	
	
end
