class Security < ActiveRecord::Base

	has_many	:price_quotes, :dependent => :destroy

	validates :ticker, :uniqueness => true

  # ----------------------------------------------------------------------------------------------------------
  # Get historical prices and save to our database
  # ----------------------------------------------------------------------------------------------------------
	def price_history(days = 30)

	  # Check whether we have the data in DB
	  historical_prices = self.price_quotes.where("date >= ?", Date.today - days).order("date DESC")

    #===== TODO: Need to check for a stock split

    # ------ Insert stock split check here -----

	  #===== Supplement missing data from Yahoo
	  h = Array.new

	  if historical_prices.empty?

      # We have no price history at all for this security
	    h = YahooFinance::get_historical_quotes_days(ticker.upcase, days)

	  else

      most_recent_date  = historical_prices.first.date
      oldest_date       = historical_prices.last.date

	    if most_recent_date != Date.today # recent data is missing
        h += YahooFinance::get_historical_quotes_days( ticker.upcase, Date.today - most_recent_date)
      end

      if oldest_date != Date.today - days # older data is missing
        h += YahooFinance::get_historical_quotes( ticker.upcase, Date.today - days, oldest_date)
      end

	  end

    #===== Save data from Yahoo into DB
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

  # ----------------------------------------------------------------------------------------------------------
  # Compare price history on Yahoo to our data in order to identify a stock split
  # ----------------------------------------------------------------------------------------------------------
  def has_split?

    # Get oldest stock price
    oldest_price_db    = self.price_quotes.where("date >= ?", Date.today - days).order("date ASC").first

    oldest_price_yahoo = YahooFinance::get_HistoricalQuotes( ticker.upcase, Date.parse( '2005-09-09' ), Date.today() )
  end



end # of class
