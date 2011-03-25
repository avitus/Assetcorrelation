class Correlation_time
  
  def initialize(tickers, period, interval)
    @tickers            = tickers
    @period             = period
    @interval           = interval

    @correlation_time   = Array.new                         # Array holding rolling correlations

    @stock_histories    = Array.new                         # historical stock series.. 
    @stock_names        = Array.new                         # ... and corresponding names
   
 end
 
 attr_reader :correlation_time, :start_date, :end_date
 
  # ----------------------------------------------------------------------------------------------------------
  # Calculate the Correlation Over Time
  # ---------------------------------------------------------------------------------------------------------- 
  def get_correlation_over_time
    # 1. Get the stock history for each ticker
    historical_quotes, days_history, shortest_ticker = yahoo_request(@tickers, @period)

    # 2. Convert series from price to return
    return_sequences = price_to_returns(historical_quotes, 2, days_history)

    # 3. Correlate over intervals
    i = 0
    
    logger.debug("**** Days of history: #{days_history}")
    logger.debug("**** Interval: #{@interval}")
    
    while i < (days_history-@interval)
      start = i
      fin   = i+@interval
      a = return_sequences[0][start..fin]
      b = return_sequences[1][start..fin]
      @correlation_time << correlation(a, b)
      i = i+1
    end
    return @correlation_time.reverse
  end

  # ----------------------------------------------------------------------------------------------------------
  # Calculate the Mean Value of a Series
  # ---------------------------------------------------------------------------------------------------------- 
  def mean(series)
    (series.size > 0) ? series.sum.to_f / series.size : 0
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
      flash[:notice] = 'Error - stock series are different lengths.'
      redirect_to :action => 'index', :id => @investment
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
  # Get price history from Yahoo
  # Inputs:   number of days of price history, list of ticker symbols
  # Outputs:  historical_quotes -- a matrix of price histories in Yahoo structure
  # ----------------------------------------------------------------------------------------------------------  
  def yahoo_request(tickers, period)    # period = number of days of history (including non-trading days)  
    
    companies          = tickers.size  # Number of companies we're requesting price history for
    historical_quotes  = Array.new     # Array of price histories...
    history_lengths    = Array.new     # ...corresponding length of price history
    requests           = 1             # Counter for number of requests to Yahoo server
    
    # Request an historical quote from Yahoo server
    # Yahoo returns only trading days of data
    for i in 0...companies
      h = YahooFinance::get_historical_quotes_days(tickers[i].upcase, period)
      historical_quotes << h
      history_lengths   << h.size
    end
    
    # Keep requesting historical quotes until Yahoo coughs up all the data
    # This should only require multiple requests infrequently (11/01/08 - reduced max reqs from 5 to 2)
    while ((history_lengths.sort.first != history_lengths.sort.last) && (requests <= 2))
      for i in 0...companies
        if (history_lengths[i] < history_lengths.sort.last)
          historical_quotes[i] = YahooFinance::get_historical_quotes_days(tickers[i].upcase, period)
          history_lengths[i]   = historical_quotes[i].size          
        end
      end
      requests = requests + 1
    end
    
    # Around 6pm (PDT) Yahoo will return historical quotes for some companies as of today and other companies
    # as of yesterday. The size will sometimes be the same, though. We need to handle this by dropping the first and last 
    # Use shift [removes first element of array] and pop [removes last element of array]

    # Correction (11/26/08) -- Sometimes the size can be different ie. same starting date but some tickers include today's
    # quote and others don't

    # vvv ---Insert code here--- vvv
    if quote_align(historical_quotes, history_lengths.max)
      logger.info("** Quote request required alignment")
      history_lengths.clear
      historical_quotes.each { |x| history_lengths << x.size }
    end
    # ^^^ ---Insert code here--- ^^^      
     
    days_history      = history_lengths.first
    shortest_history  = history_lengths.index(history_lengths.min)    
    
    # We have a couple of options if some stocks have shorter history
    #   a) truncate the entire request - easy to implement
    #   b) report an error and force user to remove shortest ticker
    if (history_lengths.min != history_lengths.max)
      shortest_ticker   = tickers[shortest_history]
      days_history      = history_lengths.min
      historical_quotes.collect! { |a| a[0...days_history] }
    end
    
    @start_date = historical_quotes[shortest_history].last[0]
    @end_date   = historical_quotes[shortest_history].first[0]
    
    return historical_quotes, days_history, shortest_ticker
  end
  
  # ----------------------------------------------------------------------------------------------------------
  # Convert price sequence into return sequence
  # ----------------------------------------------------------------------------------------------------------  
  def price_to_returns(yahoo_history, num_companies, days_of_history)   
    # Construct stock series to calculate correlation coefficients
    # Use daily returns to calculate correlation matrix
    stock_sequences = Array.new    # sequence of daily returns
    
    # Extract adjusted closing prices and calculate daily returns
    for company in 0...num_companies 
      series_build  = Array.new
      daily_returns = Array.new
      for day in 0...days_of_history
        series_build << yahoo_history[company][day][6].to_f
      end

      for day in 1...days_of_history
        daily_returns << (series_build[day]-series_build[day-1]) / series_build[day-1]
      end      
            
      stock_sequences  << daily_returns
      
      # Set the opening/closing prices and period return while we're here
      # @stock_open      << series_build.last
      # @stock_close     << series_build.first
      # @stock_returns   << (series_build.first - series_build.last) / series_build.last * 100
    end
    return stock_sequences
  end

  # ----------------------------------------------------------------------------------------------------------
  # Aligns historical quotes returned by Yahoo
  # See: http://www.transparentech.com/opensource/yahoofinance
  # Input: Yahoo historical quote array = [ company, company, company ... ]
  #                             company = [ quote[today], quote[yesterday], ... ]
  #                               quote = [ date[0], open[1], high[2], low[3], close[4], vol[5], adj_close[6] ] 
  # 
  # ----------------------------------------------------------------------------------------------------------  
  
  def quote_align(quote_array, required_trading_days)
    
    final_dates = Array.new
    start_dates = Array.new
    
    quote_array.each do |x| 
      final_dates << x.first[0] # should be today or yesterday
      start_dates << x.last[0]
    end
    
    if (final_dates.min == final_dates.max) and (start_dates.min == start_dates.max)
      return false  # No alignment required
    else
      final_date = final_dates.min
      start_date = start_dates.max
      
      quote_array.each do |x|
        if x.first[0] > final_date
          x.shift
        end
        
        # Does this mess up the case where one stock has a much shorter history?
        if x.last[0] < start_date
          x.pop
        end     
      end
      logger.info("***** Historical quote array was adjusted: #{Time.now}")
      return true # Alignment was performed
    end
    
  end  

end