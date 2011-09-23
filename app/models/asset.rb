class Asset < ActiveRecord::Base
	
	has_many		:price_quotes
	
	validates :ticker, :uniqueness => true
	
	
end
