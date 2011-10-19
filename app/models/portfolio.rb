class Portfolio < ActiveRecord::Base
	
	has_many		:positions, :dependent => :destroy
	has_many    :securities, :through => :positions
	belongs_to	:user
	
	accepts_nested_attributes_for :positions
	accepts_nested_attributes_for :securities
	
	attr_accessible :name, :positions_attributes, :securities_attributes
		
end
