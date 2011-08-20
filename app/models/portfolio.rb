class Portfolio < ActiveRecord::Base
	
	has_many		:positions, :dependent => :destroy
	has_many    :assets, :through => :positions
	belongs_to	:user
	
	accepts_nested_attributes_for :positions
	accepts_nested_attributes_for :assets
	
	attr_accessible :name, :positions_attributes, :assets_attributes
		
end
