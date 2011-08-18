class Portfolio < ActiveRecord::Base
	
	has_many		:positions
	has_many    :assets, :through => :positions
	belongs_to	:user
	
	accepts_nested_attributes_for :positions
	
	attr_accessible :name, :positions_attributes
		
end
