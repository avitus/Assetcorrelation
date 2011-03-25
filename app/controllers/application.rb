# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
 
class Array
  
  def mean 
    sum / size
  end
  
  def geometric_mean
    inject(1){ |product, n| product * n } ** (1.0/length)
  end  
  
end

  


class ApplicationController < ActionController::Base
  
  helper Ziya::HtmlHelpers::Charts
  helper Ziya::YamlHelpers::Charts
  
  
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_fundsim_session_id'

  private 
  
  # ========= Methods below this line are PRIVATE =================

  # ----------------------------------------------------------------------------------------------------------
  # Bucketize any array
  # Input: number of buckets, an array of numbers
  # Output: intervals
  # ----------------------------------------------------------------------------------------------------------   
  def bucketize(num_buckets, data)
    
  end


  # ----------------------------------------------------------------------------------------------------------
  # Save correlation matrix data to db
  # Input: correlation_matrix object
  # ----------------------------------------------------------------------------------------------------------   
  
  def save_port_to_db(corr_matrix)
    

    @portfolio            = find_portfolio # Get portfolio out of session
    
    @portfolio.port_ret   = corr_matrix.portfolio_return
    @portfolio.period     = quantalign( corr_matrix.period_actual )
    @portfolio.std_dev    = corr_matrix.portfolio_stdev
    @portfolio.intra_corr = corr_matrix.diversification_measure
    @portfolio.tickers    = corr_matrix.ticker_string
    
    session[:portfolio]   = @portfolio
    session[:matrix]      = corr_matrix     
 
    logger.debug("=== Saving portfolio: #{@portfolio.username}")  
    
    return @portfolio.save
     
  end
 
  # ----------------------------------------------------------------------------------------------------------
  # Save updated portfolio -- NOTE: does not pull portfolio out of session
  # ----------------------------------------------------------------------------------------------------------  
  def save_matrix_data_to_port(corr_matrix, portfolio)
     
    portfolio.port_ret   = corr_matrix.portfolio_return
    portfolio.period     = quantalign(corr_matrix.period_actual)
    portfolio.std_dev    = corr_matrix.portfolio_stdev
    portfolio.intra_corr = corr_matrix.diversification_measure
    portfolio.tickers    = corr_matrix.ticker_string
 
    logger.debug("=== Saving portfolio -- #{portfolio.username}")  
  
    return portfolio.save
     
  end 
  
  # ----------------------------------------------------------------------------------------------------------
  # Aligns requested period to month, quarter, year, decade etc. Needed to account for non-trading days
  # ----------------------------------------------------------------------------------------------------------   
  def quantalign(period)
    requested = case period
      when   26..86   then   31
      when   87..177  then   91
      when  178..359  then  183
      when  360..725  then  366 # should be 361 on lower bound
      when  726..1821 then  731
      when 1822..3647 then 1826
      when 3648..7289 then 3652
      when 7290..7307 then 7304 # add a bit of extra buffer to make sure nothing gets out
      else period
    end
    return requested
  end
 

  # ----------------------------------------------------------------------------------------------------------
  # Search for invalid tickers in a string of tickers and returns ticker symbol of first invalid ticker
  # Returns -1 if all tickers are valid
  # Returns nil if ticker string is empty
  # Input: String of tickers eg. "csco msft amgn"
  # ----------------------------------------------------------------------------------------------------------   
  
  def invalid_tickers(ticker_string)
     valid = Array.new
     
     if ( ticker_string.nil? || ticker_string.empty? )
       return nil
     end
     
     ticker_string.gsub(',',' ').upcase.split.each { |a| valid << ticker_exists(a) }
     if valid.include?(false)
      return ticker_string.split[valid.index(false)]
    else
      return -1
    end
  end  
  
  # ----------------------------------------------------------------------------------------------------------
  # Check that call to Yahoo returns a valid quote - Return TRUE if ticker is ok
  # ----------------------------------------------------------------------------------------------------------   
  
  def ticker_exists(ticker)
    quote_type  = YahooFinance::StandardQuote
    quote       = YahooFinance::get_quotes( quote_type, ticker )
    # A valid return will result in quote[ticker].nil? and quote[ticker].blank? being false. 
    # However, even if the ticker does not exist, the call to YahooFinance will result in a 
    # valid quote but the date field will be "N/A"
    # 10/15/2008 -- Some money market funds return a valid date field but have no trading history

    if quote[ticker.upcase].nil? 
      return false
    else
      # Check for 5 days of history and a valid date field
      has_history = YahooFinance::get_historical_quotes_days(ticker, 7).size > 0
      return (quote[ticker.upcase].date != "N/A") && has_history
    end
  end 
  

  # ----------------------------------------------------------------------------------------------------------
  # Get names from tickers
  # Input:  ["MSFT", "CSCO"] -- an array of upcased ticker symbols
  # Output: ["Microsoft", "Cisco"] -- an array of names
  # ----------------------------------------------------------------------------------------------------------   
  
  def tickers_to_names(tickers)
    
    # Request a StandardQuote to get the company names
    quote_type = YahooFinance::StandardQuote
    quotes     = YahooFinance::get_quotes( quote_type, tickers )

    # Check that tickers exist

    # create array of names
    name_array = Array.new
    tickers.each { |x| name_array << quotes[x.upcase].name.titleize }
    return name_array
  end  
  
  # ----------------------------------------------------------------------------------------------------------
  # Get name from ticker
  # Input:  "MSFT"      -- an upcased ticker symbol
  # Output: "Microsoft" -- a name
  # ----------------------------------------------------------------------------------------------------------   
  
  def ticker_to_name(ticker)
    
    # Request a StandardQuote to get the company name
    quote_type = YahooFinance::StandardQuote
    quote      = YahooFinance::get_quotes( quote_type, ticker )

    return quote[ticker].name.titleize
  end   
  
  
  
  # ----------------------------------------------------------------------------------------------------------
  # Returns number of assets in a ticker string
  # ----------------------------------------------------------------------------------------------------------  
  def num_assets_in_string(ticker_string)
    return ticker_string.gsub(',',' ').split.length
  end

  # ----------------------------------------------------------------------------------------------------------
  # Get portfolio out of session. If it doesn't exist, create a new object
  # ----------------------------------------------------------------------------------------------------------  
  def find_portfolio
    session[:portfolio] ||= Portfolio.new
  end

  # ----------------------------------------------------------------------------------------------------------
  # Calculate the variance of a series
  # ----------------------------------------------------------------------------------------------------------  
  def variance(series)
    n = 0
    avg = 0.0
    s = 0.0
    series.each { |x|
      n = n + 1
      delta = x - avg
      avg = avg + (delta / n)
      s = s + delta * (x - avg)
    }
    # if you want to calculate std deviation
    # of a sample change this to "s / (n-1)"
    return s / n
  end

  # ----------------------------------------------------------------------------------------------------------
  # Calculate the standard deviation of a population
  # Inputs an array, the population
  # Outputs: the standard deviation
  # ----------------------------------------------------------------------------------------------------------  
  def standard_deviation(population)
    Math.sqrt(variance(population))
  end


end
