class Array
  def every(n)
    select {|x| index(x) % n == 0}
  end
end

class Correlation_matrix
    
  # Constants
  MA                    = 20                                # maximum number of assets
    
  def initialize(period)
    @period_req         = period                            # number of days in period request
    @period_actual      = 0                                 # number of days in returned period
    @trading_days       = 0                                 # actual number of trading days, ie. num of days in series
    @days_of_data       = 0                                 # number of trading days in history ie. accounts for using weekly data
    @correlation_matrix = Array.new(MA){Array.new(MA,0)}    # 2d array holding correlation coefficients, init val = 0
    @stock_histories    = Array.new                         # historical stock series.. 
    @stock_names        = Array.new                         # ... and corresponding tickers
    @stock_fullnames    = Array.new                         # full company/asset name
    @stock_stddevs      = Array.new                         # standard deviation for each stock
    @stock_returns      = Array.new                         # Hold returns over given period
    @stock_open         = Array.new                         # Opening price for period
    @stock_close        = Array.new                         # Closing price for period
    @slots_open         = MA                                # Initialize to same size as matrix
    @trading_dates      = Array.new                         # Array of dates for which we have price data 
  end

  # Size of a correlation_matrix object with 20 stocks, 5 years
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # @stock_histories      = 20 * 52 weeks * 5 years = 5200 closing prices
  # @stock_returns        = 20 * 52 weeks * 5 years = 5200 return numbers
  # @correlations_matrix  = 20 * 20                 =  400 correlations
  
  attr_reader :period_req, :period_actual, 
              :size, :start_date, :end_date,       # size = number of series in correlation matrix
              :stock_histories, 
              :stock_stddevs, :stock_fullnames,
              :stock_names, :trading_days,
              :stock_open, :stock_close, :stock_returns,
              :slots_left
              
  # ----------------------------------------------------------------------------------------------------------
  # Add multiple stocks to the correlation matrix
  # Input: array of tickers, number of days
  # ----------------------------------------------------------------------------------------------------------  
  def add_many_stocks(tickers)
  
    if (tickers.size > @slots_open)
      # Not enough space to insert all tickers
      tickers = tickers[0..@slots_open]
    end
    
    # 1) Get price history from Yahoo
    yahoo_quotes, shortest_ticker, error_code  = quote_request(tickers, @period_req)
    if error_code == 1 # too little history to add asset
      return shortest_ticker
    end

    # 2) Convert to daily returns (!! Do we need num_companies??)
    num_companies               = yahoo_quotes.size
    stock_sequences             = price_to_returns(yahoo_quotes, num_companies)

    # 3) Build correlation matrix
    stock_sequences.each_index { |c|
      add_stock( tickers[c], stock_sequences[c] )
    }

    # 4) Request a StandardQuote to get the full company names
    @stock_fullnames.concat( tickers_to_names(tickers) )
      
    return shortest_ticker
  end

  # ----------------------------------------------------------------------------------------------------------
  # Add a single stock to the correlation matrix
  # Inputs: name        - name of asset
  #         new_series  - series of returns
  # ----------------------------------------------------------------------------------------------------------  
  def add_stock(name, new_series)
    # add stock to list of series
    @stock_names     << name
    @stock_histories << new_series  # series of *returns*
    @stock_stddevs   << standard_deviation(new_series) * 100


    if @stock_histories.size != 1
      for col in 0...(@stock_histories.size-1)
        @correlation_matrix[(@stock_histories.size-2)][col] = correlation(@stock_histories[col], new_series)
      end
    end
    slots_left # function call to update remaining number of slots
  end


  # ----------------------------------------------------------------------------------------------------------
  # Remove a single asset from the correlation matrix
  # Inputs: ticker        - name of asset (ticker)
  # ----------------------------------------------------------------------------------------------------------  
  def remove_stock(ticker)
 
    # Get index for removal
    index = @stock_names.index(ticker)    
 
    unless index.nil?
      @stock_histories.delete_at(index)                    # historical stock series.. 
      @stock_names.delete_at(index)                        # ... and corresponding tickers
      @stock_fullnames.delete_at(index)                    # full company/asset name
      @stock_stddevs.delete_at(index)                      # standard deviation for each stock
      @stock_returns.delete_at(index)                      # Hold returns over given period
      @stock_open.delete_at(index)                         # Opening price for period
      @stock_close.delete_at(index)                        # Closing price for period       
  
      # remove row and col from correlation matrix   
      @correlation_matrix.delete_at(index)
      @correlation_matrix.each { |x| x.delete_at(index) }
      
      # add back a new row and col to maintain matrix size
      @correlation_matrix << Array.new(MA-1,0)
      @correlation_matrix.each { |x| x << 0 }
      
    end      
  end


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
      
    if (@trading_days>0) # that is, we're adding stocks to an existing portfolio
      
      # If the stocks we're adding have more history than the existing portfolio, we need to truncate
      if (history_lengths.min >= @trading_days)
        Rails.logger.info("==== Truncating because stock being added has less history than existing portfolio")
        historical_quotes.collect! { |a| a[0...@trading_days] }
      else
      # If the stocks we're adding have less history than the existing portfolio, we need to return an error
        shortest_ticker = tickers[shortest_history]
        return historical_quotes, shortest_ticker, 1  # error code = 1 = too little history to continue
      end
      
    else   
      @trading_days = history_lengths.min  # set number of trading days for the matrix
      Rails.logger.debug("** Setting number of trading days to #{@trading_days}")
    end
    
    # This next line of code often generates an error while evaluating nil.[] (1 occurence to date)
    # Possibly add check for .nil? -- not sure why this occurs
    @start_date = historical_quotes[shortest_history].last.date
    @end_date   = historical_quotes[shortest_history].first.date
    
    # startdate   = Date.parse(@start_date)
    # enddate     = Date.parse(@end_date)    
    
    # 12/08/08 No longer adding one to period_actual calculation
    # 12/10/08 Changed back to adding one 
    # 12/16/08 Taking it out again 
    @period_actual  = (@end_date - @start_date).to_i   
    
    return historical_quotes, shortest_ticker, 0
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
      h = Asset.find_by_ticker(t).price_history(period_req)
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
  def price_to_returns(yahoo_history, num_companies)   
    # Construct stock series to calculate correlation coefficients
    # Use daily returns to calculate correlation matrix
    stock_sequences = Array.new    # sequence of daily returns
    num_years  = @period_actual / 365.25    
    
    # Extract adjusted closing prices and calculate daily returns
    for company in 0...num_companies 
      series_build  = Array.new
      daily_returns = Array.new  # could be weekly in the case of longer periods
      
      for day in 0...@trading_days
        series_build << yahoo_history[company][day].price.to_f
      end
      
      # Set the opening/closing prices and period return while we're here
      # Should we rather use ln S1/S2 to calculate returns?
      @stock_open      << series_build.last
      @stock_close     << series_build.first
      
      if num_years >= 1.0
        @stock_returns << (((series_build.first / series_build.last) **  ( 1/num_years)) - 1) * 100
      else
        @stock_returns << (series_build.first / series_build.last - 1) * 100
      end

      # Convert to weekly data for longer periods  
      if @trading_days > 20000 # 50 years  
        series_build  = series_build.every(5) # This doesn't seem to work reliably
        @days_of_data = series_build.length
      end
      
      for day in 1...series_build.length
        daily_returns << ((series_build[day]-series_build[day-1]) / series_build[day-1])
      end      
            
      stock_sequences  << daily_returns
      
    end
    return stock_sequences
  end
  
  
    def [](row, col)
    @correlation_matrix[row][col]
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
      logger.info("*!*!*!* Yikes: Port stdev is negative when it shouldn't be: #{port_stdev}")
      return 0 # Error condition
    else
      return Math.sqrt( port_stdev / (num_assets+1)**2 )
    end
  end 

  # ----------------------------------------------------------------------------------------------------------
  # Check whether correlation matrix is full
  # ----------------------------------------------------------------------------------------------------------    
  def overflowing
    return @stock_names.length >= MA
  end
  
  # ----------------------------------------------------------------------------------------------------------
  # Return space remaining
  # ----------------------------------------------------------------------------------------------------------    
  def slots_left
    @slots_open =  (MA - @stock_names.length) 
  end 
  
   
  # ----------------------------------------------------------------------------------------------------------
  # Calculate the intra-portfolio correlation
  # ----------------------------------------------------------------------------------------------------------    
  def diversification_measure
    b = @stock_names.length
    a = @correlation_matrix.flatten
    
    if (b<2)
      return 1  # avoid div by 0 
    else
      return a.inject {|sum, element| sum+element} / ((b*b-b)/2)
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
      logger.error 'Error - stock series are different lengths.'
      logger.error("A #{a.size}")
      logger.error("B #{b.size} -- new asset")      
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
  # Get names from tickers
  # Input: ["MSFT", "CSCO"]                 -- an array of upcased ticker symbols
  # Output:["Microsoft Corp", "Cisco Corp"] -- an array of titleized names
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
    
    Rails.logger.info("== Setting all histories to length: #{required_trading_days}")
    # For each company - check whether there are any dates missing from golden date array and add them
    Rails.logger.info("== Compiling date array")
    quote_array.each do |asset|
      asset.each do |quote|
        @trading_dates << quote[0] # add date to array
      end
    end
    @trading_dates.uniq! # remove redundant dates
    
    Rails.logger.info("== Checking for missing dates")
    # For each company - insert missing data
    @trading_dates.each do |date|
      quote_array.each do |asset|
        if asset.length < required_trading_days
          # If asset doesn't include date then we need to add data by copying previous day
          if !asset.flatten.include?(date)    # ie. missing data
            logger.info("** Found missing data on #{date}. Nothing is being done about it yet")
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