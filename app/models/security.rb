class Security < ActiveRecord::Base

	has_many	:price_quotes, :dependent => :destroy
  has_many  :positions, :dependent => :destroy

	validates :ticker, :uniqueness => true

  # ----------------------------------------------------------------------------------------------------------
  # Get historical prices and save to our database
  # ----------------------------------------------------------------------------------------------------------
	def price_history(days = 30)


    #===== TODO: Need to check for a stock split

    # ------ Insert stock split check here -----

	  # Check whether we have the data in DB
	  historical_prices = self.price_quotes.where("date >= ?", Date.today - days).order("date DESC")


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
    # TODO: extract this into a separate helper method
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
    oldest_quote_db    = self.price_quotes.order("date ASC").first

    if oldest_quote_db

      oldest_date_db     = oldest_quote_db.date  unless !oldest_quote_db
      oldest_price_db    = oldest_quote_db.price unless !oldest_quote_db

      oldest_quote_yahoo = YahooFinance::get_HistoricalQuotes( ticker.upcase, oldest_date_db, oldest_date_db )

      if !oldest_quote_yahoo.blank? # we were able to get a quote for that date

        oldest_date_yahoo  = Date.parse(oldest_quote_yahoo[0].to_a[1])
        oldest_price_yahoo =            oldest_quote_yahoo[0].to_a[7]
        # check that we're comparing prices from the same day
        return ( (oldest_date_yahoo == oldest_date_db) and (oldest_price_yahoo != oldest_price_db) )

      else # Yahoo returned []

        return true  # we have data in our database that doesn't exist in the Yahoo DB --> throw out our data

      end

    else

      return false  # we have no data so no need to do anything

    end

  end

  # ----------------------------------------------------------------------------------------------------------
  # Latest closing price
  # ----------------------------------------------------------------------------------------------------------
  def closing_price

    # Check whether we have the data in DB
    last_close = self.price_quotes.where("date >= ?", Date.today - 1).first

    # Get last 3 days to account for long weekends
    if !last_close
      Rails.logger.debug("*** Pinging Yahoo for closing price for #{self.ticker}")
      last_close = Array.new
      last_close += YahooFinance::get_historical_quotes_days( ticker.upcase, 3 )
      Rails.logger.debug("***    Quote: #{last_close.inspect}")

      # ===== Save data from Yahoo into DB
      # TODO: extract this into a separate helper method
      last_close.each { |yahoo_quote|

        yahoo_date = Date.parse(yahoo_quote[0])
        if self.price_quotes.exists?(:date => yahoo_date)
          # Skip
        else
          self.price_quotes.create(:date => yahoo_date, :price => yahoo_quote[6].to_f)
        end

      }

      if !last_close.empty?
        return last_close.first[6]  # 6th element in array is adjusted closing price
      else
        return nil # handles case where Yahoo stops returning price history for a once valid security. Security should be removed
      end

    else

      return last_close.price

    end

  end

  # ----------------------------------------------------------------------------------------------------------
  # Check whether security has any price history on Yahoo
  # ----------------------------------------------------------------------------------------------------------
  def has_history?

    # Check with Yahoo
    Rails.logger.info("=== Querying Yahoo for security: #{self.ticker}")
    ticker = self.ticker
    quote_type  = YahooFinance::StandardQuote
    quote       = YahooFinance::get_quotes( quote_type, ticker )
    # A valid return will result in quote[ticker].nil? and quote[ticker].blank? being false.
    # However, even if the ticker does not exist, the call to YahooFinance will result in a
    # valid quote but the date field will be "N/A"
    # 10/15/2008 -- Some money market funds return a valid date field but have no trading history

    if quote[ticker]

      # Check for 5 days of history and a valid date field
      has_history = YahooFinance::get_historical_quotes_days(ticker, 7).size > 0
      return (quote[ticker].date != "N/A") && has_history

    else

      return false

    end

  end

end # of class
