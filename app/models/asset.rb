class Asset < ActiveRecord::Base
	
	has_many		:price_quotes
	belongs_to  :position
	belongs_to  :portfolio
	
	validates :ticker, :uniqueness => true
	
	
end
