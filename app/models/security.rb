class Security < ActiveRecord::Base
	
	has_many	:price_quotes, :dependent => :destroy
	
	validates :ticker, :uniqueness => true
	
	def price_history(days = 30)
	  
	  # Check whether we have the data in DB
	  historical_prices = self.price_quotes.where("date >= ?", Date.today - days).order("date DESC")
 	  
	  # Supplement missing data from Yahoo
	  h = Array.new
	  if historical_prices.empty?

	    h = YahooFinance::get_historical_quotes_days(ticker.upcase, days)

	  else
	    
      most_recent_date  = historical_prices.first.date
      oldest_date       = historical_prices.last.date  	    
	    
	    if most_recent_date != Date.today
        h += YahooFinance::get_historical_quotes_days( ticker.upcase, Date.today - most_recent_date)
      end
      
      if oldest_date != Date.today - days
        h += YahooFinance::get_historical_quotes( ticker.upcase, Date.today - days, oldest_date)
      end        	  

	  end
	  
	  
    # Save data from Yahoo into DB
    h.each { |yahoo_quote|
      yahoo_date = Date.parse(yahoo_quote[0])
      if self.price_quotes.exists?(:date => yahoo_date)
        # Skip
      else
        self.price_quotes.create(:date => yahoo_date, :price => yahoo_quote[6].to_f)
      end
    }   	  
	    
    return self.price_quotes.where("date >= ?", Date.today - days).order("date DESC")

	end
	
	
end # of class
