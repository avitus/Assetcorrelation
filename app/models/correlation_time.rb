class Correlation_time
    
  def initialize(tickers, period, interval)
    
    @tickers = tickers
    @period = period
    @interval = interval

    @correlation_time = Array.new     # Array holding rolling correlations

    @stock_histories = Array.new      # historical stock series..
    @stock_names = Array.new          # ... and corresponding names    
    
  end

  attr_reader :correlation_time, :start_date, :end_date


  # ----------------------------------------------------------------------------------------------------------
  # Calculate the Correlation Over Time
  # ----------------------------------------------------------------------------------------------------------
  def get_correlation_over_time
    
    # 1. Get the stock history for each ticker
    historical_quotes, days_history, shortest_ticker = quote_request(@tickers, @period)

    # 2. Convert series from price to return
    return_sequences = price_to_returns(historical_quotes, 2, days_history)

    # 3. Correlate over intervals
    i = 0
    
    while i < (days_history-@interval)
      start = i
      fin = i+@interval
      a = return_sequences[0][start..fin]
      b = return_sequences[1][start..fin]
      @correlation_time << correlation(a, b)
      i = i+1
    end
    return @correlation_time.reverse
  end

  # ------- Matrix stuff below this line ----------------------   

  # ----------------------------------------------------------------------------------------------------------
  # Get price history
  # Inputs:   number of days of price history, list of ticker symbols in string format
  # Outputs:  historical_quotes -- a matrix of price histories in Yahoo structure
  # ----------------------------------------------------------------------------------------------------------  
  def quote_request(tickers, period_req)    # period = number of days of history (including non-trading days)  

    historical_quotes  = Array.new     # Array of price histories...
    history_lengths    = Array.new     # ...corresponding length of price history
  
    historical_quotes, history_lengths = ping_yahoo(tickers, period_req)
    
    # If some stocks have insufficient history then the request is truncated
    shortest_history  = history_lengths.index(history_lengths.min)  # asset with shortest history   
    if (history_lengths.min != history_lengths.max)
      Rails.logger.info("==== Truncating...")
      shortest_ticker    = tickers[shortest_history]
      historical_quotes.collect! { |a| a[0...history_lengths.min] }
    end
          
    if shortest_history
      @start_date = historical_quotes[shortest_history].last.date
      @end_date   = historical_quotes[shortest_history].first.date  
      @period_actual  = (@end_date - @start_date + 1).to_i         
    else
      Rails.logger.warn("Error: couldn't find asset with shortest history while adding #{tickers}")
    end
    
    return historical_quotes, history_lengths.min, shortest_ticker
  end
  

  # ----------------------------------------------------------------------------------------------------------
  # Get price history from Yahoo
  # Inputs:   number of days of price history, list of ticker symbols (already checked for invalid tickers)
  # Outputs:  historical_quotes -- a matrix of price histories in Yahoo structure
  # TODO: This method should be moved somewhere else
  # ----------------------------------------------------------------------------------------------------------   
  def ping_yahoo(tickers, period_req)

    requests          = 1             # Counter for number of requests to Yahoo server
    historical_quotes = Array.new     # Array of price histories...
    history_lengths   = Array.new     # ...corresponding length of price history

    # Request an historical quote from Yahoo server
    # Yahoo returns only trading days of data
    tickers.each { |t|
      # h = YahooFinance::get_historical_quotes_days(t.upcase, period_req) 
      h = Security.find_by_ticker(t).price_history(period_req)
      historical_quotes << h
      history_lengths   << h.size    
    }
        
    # Around 6pm (PDT) Yahoo will return historical quotes for some companies as of today and other companies
    # as of yesterday. The size will sometimes be the same, though. We need to handle this by dropping the first and last 
    # Use shift [removes first element of array] and pop [removes last element of array]

    # Correction (11/26/08) -- Sometimes the size can be different ie. same starting date but some tickers include today's
    # quote and others don't

    # vvv ---Insert code here--- vvv
    if quote_align(historical_quotes, history_lengths.max)
      Rails.logger.info("=== Quote request required alignment")
      history_lengths.clear
      historical_quotes.each { |x| history_lengths << x.size }
    end
    # ^^^ ---Insert code here--- ^^^    
    
    
    # If lengths are different but start and end dates are the same then we have missing data
    if history_lengths.sort.first != history_lengths.sort.last and start_end_ok(historical_quotes)
      Rails.logger.info("=== Checking for missing quote data")
      quote_insertion(historical_quotes, history_lengths.max)
    end
    
    return historical_quotes, history_lengths
  end
  
  # ----------------------------------------------------------------------------------------------------------
  # Convert price sequence into return sequence
  # ----------------------------------------------------------------------------------------------------------
  def price_to_returns(yahoo_history, num_companies, days_of_history)
    # Construct stock series to calculate correlation coefficients
    # Use daily returns to calculate correlation matrix
    stock_sequences = Array.new # sequence of daily returns
    
    # Extract adjusted closing prices and calculate daily returns
    for company in 0...num_companies
      series_build = Array.new
      daily_returns = Array.new
      for day in 0...days_of_history
        series_build << yahoo_history[company][day].price.to_f
      end

      for day in 1...days_of_history
        daily_returns << (series_build[day]-series_build[day-1]) / series_build[day-1]
      end
            
      stock_sequences << daily_returns
      
      # Set the opening/closing prices and period return while we're here
      # @stock_open << series_build.last
      # @stock_close << series_build.first
      # @stock_returns << (series_build.first - series_build.last) / series_build.last * 100
    end
    return stock_sequences
  end
  

  def mean(series)
    (series.size > 0) ? series.sum.to_f / series.size : 0
  end
 
  # ----------------------------------------------------------------------------------------------------------
  # Portfolio Return -- Assuming Equal Weights
  # ----------------------------------------------------------------------------------------------------------    
  def portfolio_return
 
    num_stocks = @stock_names.length # number of assets in portfolio
    openval    = @stock_open.map { |price| 1/price }
    closevals  = @stock_close
    num_years  = @period_actual / 365.25
    
    final_val = openval.zip(closevals).inject(0) do |dp,(openval,closevals)| dp + openval*closevals end
    
    if (num_stocks==0)
      return 0
    else
      if num_years >= 1.0
        return (((final_val / num_stocks) ** ( 1 / num_years)) - 1) * 100
      else
        return (final_val / num_stocks - 1 ) * 100
      end
    end
  end  
  
  # ----------------------------------------------------------------------------------------------------------
  # Portfolio Standard Deviation -- Assuming Equal Weights
  # ----------------------------------------------------------------------------------------------------------    
  def portfolio_stdev
    
    # Formula: port_stdev = Sum ( i, j) [ W(i) * W(j) *  Stdev(i) * Stdev(j) * Corr(i,j) ]
    # For W=1: port_stdev = Sum ( i, j) [ Stdev(i) * Stdev(j) * Corr(i,j) ]
    # We can probably use a formula similar to the one for diversification_measure()
    
    
    if @stock_names.empty? 
      return 0
    end
    
    num_assets = @stock_names.length-1
    port_stdev = 0
        
    for col in 0...num_assets
      for row in col...num_assets
        port_stdev += (@correlation_matrix[row][col] * @stock_stddevs[row+1] * @stock_stddevs[col] * 2)  
      end
      port_stdev += @stock_stddevs[col] * @stock_stddevs[col]
    end
    port_stdev += @stock_stddevs[num_assets] * @stock_stddevs[num_assets]
    
    if port_stdev<0
      Rails.logger.info("*!*!*!* Yikes: Port stdev is negative when it shouldn't be: #{port_stdev}")
      return 0 # Error condition
    else
      return Math.sqrt( port_stdev / (num_assets+1)**2 )
    end
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

  # ----------------------------------------------------------------------------------------------------------
  # Calculate correlation between two series
  # ----------------------------------------------------------------------------------------------------------  
  def correlation(a, b)
    
    corr = 0
    # check that a and b are the same length
    if a.size != b.size
      Rails.logger.error 'Error - stock series are different lengths.'
      Rails.logger.error("A #{a.size}")
      Rails.logger.error("B #{b.size} -- new asset")      
      return -2 # This is an error condition
    else
      # calculate correlation coefficient
      mean_a = mean(a)
      mean_b = mean(b)
      for i in 0...a.size
        corr = corr + ( a[i]-mean_a ) * ( b[i]-mean_b )
      end
      corr / (a.size * standard_deviation(a) * standard_deviation(b))
    end
  end
  
  # ----------------------------------------------------------------------------------------------------------
  # Returns list of tickers as a string
  # Output: "MSFT OMTR SPY EEM" -- a capitalized string of ticker symbols separated by a space
  # ----------------------------------------------------------------------------------------------------------   
  def ticker_string
    @stock_names.join(" ")
  end
  
  # ----------------------------------------------------------------------------------------------------------
  # Aligns historical quotes returned by Yahoo
  # See: http://www.transparentech.com/opensource/yahoofinance
  # Input: Yahoo historical quote array = [ company, company, company ... ]
  #                             company = [ quote[today], quote[yesterday], ... ]
  #                               quote = [ date[0], open[1], high[2], low[3], close[4], vol[5], adj_close[6] ] 
  # ----------------------------------------------------------------------------------------------------------  
  def quote_align(quote_array, required_trading_days)
    
    final_dates = Array.new
    start_dates = Array.new
    
    quote_array.each do |x| 
      final_dates << x.first.date # should be today or yesterday
      start_dates << x.last.date
    end
    
    if (final_dates.min == final_dates.max) and (start_dates.min == start_dates.max)
      return false  # No alignment required
    else
      final_date = final_dates.min
      start_date = start_dates.max
      
      quote_array.each do |x|
        if x.first.date > final_date
          x.shift
        end
        
        # Does this mess up the case where one stock has a much shorter history?
        if x.last.date < start_date
          x.pop
        end     
      end
      Rails.logger.info("***** Historical quote array was adjusted: #{Time.now}")
      return true # Alignment was performed
    end
    
  end

  # ----------------------------------------------------------------------------------------------------------
  # Adds missing data to historical quotes returned by Yahoo
  # See: http://www.transparentech.com/opensource/yahoofinance
  # Input: Yahoo historical quote array = [ asset0, asset1, asset2 ... ]
  #                               asset = [ quote[today], quote[yesterday], ... ]
  #                               quote = [ date[0], open[1], high[2], low[3], close[4], vol[5], adj_close[6] ] 
  # 
  # ----------------------------------------------------------------------------------------------------------  
  
  def quote_insertion(quote_array, required_trading_days )
    
    trading_dates = Array.new
    Rails.logger.info("== Setting all histories to length: #{required_trading_days}")
    # For each company - check whether there are any dates missing from golden date array and add them
    Rails.logger.info("== Compiling date array")
    quote_array.each do |asset|
      asset.each do |quote|
        trading_dates << quote.date # add date to array
      end
    end
    trading_dates.uniq! # remove redundant dates
    
    Rails.logger.info("== Checking for missing dates")
    # For each company - insert missing data
    trading_dates.each do |date|
      quote_array.each do |asset|
        if asset.length < required_trading_days
          # If asset doesn't include date then we need to add data by copying previous day
          # However, there are two cases -- one where a stock traded on a public holiday e.g. DIA on 2010-01-18
          # The other is where a stock didn't traded on a day it should have.
          if !asset.flatten.include?(date)    # ie. missing data
            Rails.logger.info("** Found missing data on #{date}. Nothing is being done about it yet")
          end         
        end
 
      end
    end
    Rails.logger.info("== Done")
  
  end
 

  # ----------------------------------------------------------------------------------------------------------
  # Check to see whether start and end dates are the same for all quote histories
  # ---------------------------------------------------------------------------------------------------------- 
 
 
  def start_end_ok(quote_array)
    final_dates = Array.new
    start_dates = Array.new
    
    quote_array.each do |x| 
      final_dates << x.first[0]
      start_dates << x.last[0]
    end
    return ((final_dates.min == final_dates.max) and (start_dates.min == start_dates.max))
  end
  
end