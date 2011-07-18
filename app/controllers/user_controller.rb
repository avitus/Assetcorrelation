# To do list
# 1) Add more readable names for common funds, asset classes etc.
# 2) Gather all stock specific data into a nice structure in correlation_matrix.rb model
# 3) Check on session expiration, log file rotation etc.
# 4) Make entering portfolio name optional
# 5) Allow search for least correlated asset with similar risk
# 6) Enable editing of time period after loading a portfolio
# 7) Fix missing data problem in both correlation_time.rb and correlation_matrix.rb
# 8) Use multi-threading to update all portfolios quicker

# Change log
# ~~~~~~~~~~
#  6/24/08 Get historic quotes -> correlation
#  7/30/08 Feature: country correlation matrix
#  7/30/08 Push functionality into correlation_matrix model - rather than in correlation controller
#  8/17/08 Check for commas in custom portfolio ticker strings
#  8/23/08 Feature: intra-portfolio diversification calculation
#  8/24/08 Static pages are now cached
#  8/26/08 Feature: multiple periods for various matrices
#  9/05/08 Check for valid tickers on user entry
#  9/15/08 Properly handle tickers with insufficient history
#  9/16/08 Feature: 'Correlation over Time' module for two stocks
# 10/09/08 Feature: load/update feature
# 10/10/08 Corrected major error in calculation of correlation matrix - now properly uses returns
# 10/15/08 Feature: Add / Delete an asset
# 10/15/08 Change: use a pull down menu for period selection
# 10/22/08 Check for too many stocks being added to matrix
# 10/31/08 Added Omniture tracking code
# 11/01/08 Bugfix: Correlation over time graph was reversed
# 11/21/08 Bugfix: Reversed inline graph for Nasdaq on stock quotes page
# 11/24/08 Added std deviations for assets and removed open/close values
# 11/26/08 Added daily standard deviation for portfolio
# 11/26/08 Fixed "5pm issue" in Yahoo stock feed
# 11/27/08 Much nicer graphing functionality using Ziya
# 11/30/08 Feature: Graph of risk vs return
# 12/31/08 Feature: Allow daily update of portfolio DB
# 01/01/09 Feature: Added stats page for admin
# 01/02/09 Feature: Store tickers in database
# 10/12/09 Feature: Added macro valuation analysis

class UserController < ApplicationController

  require 'rubygems'
  require 'yahoofinance'

  helper :sparklines

  caches_page :index, :history, :correlations, :countries, :sectors, :primer, :history, :bonds, 
              :faq, :simple_asset_allocation


  def index
  end
  
  def primer
  end

  def contact
    @page_title = "Asset Correlations: Contact / Feedback" 
  end

  def history
  end
  
  def outcome_matrix
    @investments = Investment.show_investments(params[:sort_order])
  end
  
  def show_details
    @investment = Investment.find(params[:id])
  end
  
  def edit_investment
    @investment = Investment.find(params[:id])
  end
  
  
  # ----------------------------------------------------------------------------------------------------------
  # Investment editing -- only used for Monte Carlo simulation
  # ----------------------------------------------------------------------------------------------------------  
  def update_investment
    @investment = Investment.find(params[:id])
    if @investment.update_attributes(params[:investment])
      flash[:notice] = 'Investment was successfully updated.'
      redirect_to :action => 'show_details', :id => @investment
    else
      render :action => 'edit_investment'
    end
  end
  
  
  # ----------------------------------------------------------------------------------------------------------
  # Stock quotes
  # ----------------------------------------------------------------------------------------------------------  
  def quote_publics      
    # http://www.transparentech.com/projects/yahoofinance
    # Set the type of quote we want to retrieve.
    # Available type are:
    #  - YahooFinanace::StandardQuote
    #  - YahooFinanace::ExtendedQuote
    #  - YahooFinanace::RealTimeQuote
    @quote_type_a  = YahooFinance::StandardQuote
    @quote_type_b  = YahooFinance::ExtendedQuote

    # Set the symbols for which we want to retrieve quotes.
    # You can include more than one symbol by separating 
    # them with a ',' (comma).
    @quote_symbols = "TIP,AGG,EMB,IGE,GSG,VNQ,RWX,EEM,EFA,VB,VV,VO,VGK,VPL,^IXIC,^GSPC"
    
    # Get the quotes from Yahoo! Finance.  The get_quotes method call
    # returns a Hash containing one quote object of type "quote_type" for
    # each symbol in "quote_symbols".  If a block is given, it will be
    # called with the quote object (as in the example below).
    @quotes      = YahooFinance::get_quotes( @quote_type_a, @quote_symbols )
    @quotes_ext  = YahooFinance::get_quotes( @quote_type_b, @quote_symbols )
    
    # Create sparkline data
    h = YahooFinance::get_historical_quotes_days("^IXIC", 90)   
    @nasdaq_yr = Array.new
    for day in 0...h.length
      @nasdaq_yr << h[day][4].to_f
    end
    @nasdaq_yr.reverse! 
    
    # Calculate Shiller 10 Yr PE Ratio
    @shiller_pe = @quotes['^GSPC'].lastTrade / Macroval.last.spcomposite.to_f * Macroval.last.pe_tenyear.to_f 
  end
  
  # ----------------------------------------------------------------------------------------------------------
  # Correlation matrix for major asset classes
  # ---------------------------------------------------------------------------------------------------------- 

  def correlations
    # 1) Locate list of tickers to create matrix
    if params[:id].nil? 
      @period=91
    else 
      @period=params[:id].to_i 
    end
    tickers   =  %w{TIP GLD AGG EMB USO GSG VNQ RWX EEM EFA VB VV VO}
    @page_title = "Asset Correlations: Major Asset Classes"    
    
        
    # 2) Build correlation matrix
    @corr_matrix = Correlation_matrix.new(@period)
    @corr_matrix.add_many_stocks(tickers, @period) 
    
    # 3) Request a StandardQuote to get the company names
    quote_type = YahooFinance::StandardQuote
    @quotes     = YahooFinance::get_quotes( quote_type, tickers ) 
    
    @quotes['TIP'  ].name = "Inflation-protected Treasuries"
    @quotes['GLD'  ].name = "Gold" 
    @quotes['AGG'  ].name = "US Bonds"
    @quotes['EMB'  ].name = "Emerging Market Bonds"  # This fund is most recent:Launched Dec 19th, 2007     
    @quotes['USO'  ].name = "Oil"
    @quotes['GSG'  ].name = "Commodities Index"
    @quotes['VNQ'  ].name = "US Real Estate"
    @quotes['RWX'  ].name = "International Real Estate"  # launched March 2nd 2007
    @quotes['EEM'  ].name = "Emerging Markets"
    @quotes['EFA'  ].name = "Europe, Australasia, Far East"
    @quotes['VB'   ].name = "US Small Cap Stocks"
    @quotes['VV'   ].name = "US Large Cap Stocks"   
    @quotes['VO'   ].name = "US Mid Cap Stocks"   
    
  end

 
  # ----------------------------------------------------------------------------------------------------------
  # Country Correlation
  # ----------------------------------------------------------------------------------------------------------    
  def countries
    # 1) Locate list of tickers to create matrix
    if params[:id].nil? 
      @period=90 
    else 
      @period=params[:id].to_i 
    end     
    tickers   = %w{^GSPC EZA EWQ EWG EWC EWD EWU EWA EWJ EWY EWT EWZ ECH EWW EIS TUR}
    @page_title = "Asset Correlations: Country Index Funds"    
    
        
    # 2) Build correlation matrix
    @corr_matrix = Correlation_matrix.new(@period)
    @corr_matrix.add_many_stocks(tickers, @period) 
    
    # 3) Request a StandardQuote to get the company names
    quote_type = YahooFinance::StandardQuote
    @quotes     = YahooFinance::get_quotes( quote_type, tickers ) 

    @quotes['^GSPC'].name = "United States"
    @quotes['EZA'  ].name = "South Africa"
    @quotes['EWQ'  ].name = "France"
    @quotes['EWG'  ].name = "Germany"
    @quotes['EWC'  ].name = "Canada"
    @quotes['EWD'  ].name = "Sweden"
    @quotes['EWU'  ].name = "United Kingdom"
    @quotes['EWA'  ].name = "Australia"
    @quotes['EWJ'  ].name = "Japan"
    @quotes['EWY'  ].name = "South Korea"   
    @quotes['EWT'  ].name = "Taiwan"   
    @quotes['EWZ'  ].name = "Brazil"   
    @quotes['ECH'  ].name = "Chile"   
    @quotes['EWW'  ].name = "Mexico"  
    @quotes['EIS'  ].name = "Israel"  
    @quotes['TUR'  ].name = "Turkey"  # This fund is most recent - launched April 1st 2008 
    
  end
  
    
  # ----------------------------------------------------------------------------------------------------------
  # Correlation matrix for 9 S&P sectors
  # ----------------------------------------------------------------------------------------------------------    
  def sectors
    # 1) Locate list of tickers to create matrix
    tickers   = %w{SPY XLY XLP XLE XLF XLV XLI XLB XLK XLU}
    if params[:id].nil? 
      @period=90 
    else 
      @period=params[:id].to_i 
    end
    @page_title = "Asset Correlations: S&P Sectors"    
        
    # 2) Build correlation matrix
    @corr_matrix = Correlation_matrix.new(@period)
    @corr_matrix.add_many_stocks(tickers, @period) 
    
    # 3) Request a StandardQuote to get the company names
    quote_type = YahooFinance::StandardQuote
    @quotes     = YahooFinance::get_quotes( quote_type, tickers )
    
    @quotes['SPY'  ].name = "S&P 500"
    @quotes['XLY'  ].name = "Consumer Discretionary"
    @quotes['XLP'  ].name = "Consumer Staples"
    @quotes['XLE'  ].name = "Energy"   
    @quotes['XLF'  ].name = "Financials"   
    @quotes['XLV'  ].name = "Healthcare"   
    @quotes['XLI'  ].name = "Industrials"   
    @quotes['XLB'  ].name = "Materials"  
    @quotes['XLK'  ].name = "Technology"  
    @quotes['XLU'  ].name = "Utilities"      
    
  end   

  # ----------------------------------------------------------------------------------------------------------
  # Correlation matrix for bond sector
  # ----------------------------------------------------------------------------------------------------------    
  def bonds
    # 1) Locate list of tickers to create matrix
    tickers   = %w{SHV SHY IEI IEF TLH TLT LQD HYG MUB EMB MBB}
    if params[:id].nil? 
      @period=90 
    else 
      @period=params[:id].to_i 
    end
    @page_title = "Asset Correlations: Bond Sector"
        
    # 2) Build correlation matrix
    @corr_matrix = Correlation_matrix.new(@period)
    @corr_matrix.add_many_stocks(tickers, @period) 
    
    # 3) Request a StandardQuote to get the company names
    quote_type = YahooFinance::StandardQuote
    @quotes     = YahooFinance::get_quotes( quote_type, tickers )
    
    @quotes['SHV'  ].name = "Treasury: Short-term"
    @quotes['SHY'  ].name = "Treasury: 1-3 Year"
    @quotes['IEI'  ].name = "Treasury: 3-7 Year"
    @quotes['IEF'  ].name = "Treasury: 7-10 Year"   
    @quotes['TLH'  ].name = "Treasury: 10-20 Year"   
    @quotes['TLT'  ].name = "Treasury: 20+ Year"   
    @quotes['LQD'  ].name = "Corporate: Investment Grade"   
    @quotes['HYG'  ].name = "Corporate: High Yield"  
    @quotes['MUB'  ].name = "Municipal Bonds"  
    @quotes['EMB'  ].name = "Emerging Market Bonds"  # Launched Dec 19th, 2007     
    @quotes['MBB'  ].name = "Mortgage-backed Securities"
    
  end  


  # ----------------------------------------------------------------------------------------------------------
  # Custom portfolio entry
  # ----------------------------------------------------------------------------------------------------------  
  def custom
    # 1) Pull portfolio out of session
    @portfolio = find_portfolio
                
    # Check to see whether we have a custom portfolio....if not, use default             
    if (@portfolio.tickers.nil?)
      tickers = %w{TIP AGG IGE GSG VNQ RWX EEM EFA VB VV VO VGK VPL ^IXIC}
      flash.now[:notice] = "Your custom portfolio was not located. Using default asset classes instead"
      @period = 90
    # Check for invalid tickers (MAYBE THIS CHECK SHOULD BE IN PORTFOLIO.RB)
    elsif (invalid_tickers(@portfolio.tickers.gsub(',',' ')) != -1)
      flash.now[:notice] = "One (and possibly more) of the ticker symbols you entered is invalid"
      @period = 30
      tickers = %w{TIP AGG GSG VNQ RWX EEM EFA }
      # ---- We should probably clean up here....at least give the portfolio a different name so it's not wasted
    else # everything is ok
      tickers = @portfolio.tickers.upcase.gsub(',',' ').split      
      @period = @portfolio.period
    end
       
    # Make sure that we're using a reasonable length of time to calculate the matrix   
    if (@period<30)
      @period = 30
      flash.now[:notice] = "Minimum meaningful period is 30 days - using that instead"
    end
    
    if (@period>7500) # Longer than 20 years
      @period = 7500
      flash.now[:notice] = "We lack the computational firepower for such a long period - using 2000 days for now"
    end
       
       
    # Check that we have at least two tickers - otherwise tough to calculate a matrix   
    if (tickers.size < 2)
      flash.now[:notice] = "Not enough tickers in custom portfolio - using default asset classes"
      tickers = %w{TIP AGG IGE GSG VNQ RWX EEM EFA VB VV VO VGK VPL ^IXIC}
    end
    
    # 2) Build correlation matrix
    @corr_matrix = Correlation_matrix.new(@period)
    ticker_err = @corr_matrix.add_many_stocks(tickers, @period)
    
    if ticker_err.nil?
      # Do nothing
    else
      flash.now[:notice] = ticker_err.upcase + " only has a stock history since " + @corr_matrix.start_date + ". Shortening period accordingly"
      sd              = ParseDate::parsedate(@corr_matrix.start_date) 
      startdate       = Date.new(sd[0], sd[1], sd[2])
      @period         = (Date.today - startdate).to_i
    end
    
    # 3) Request a StandardQuote to get the company names
    # quote_type = YahooFinance::StandardQuote
    # @quotes    = YahooFinance::get_quotes( quote_type, tickers )

    # 4) Load portfolio from database
    
    # 5) Write internal correlation coefficient and standard deviation to database
    save_port_to_db(@corr_matrix)
      
  end
  
  # ----------------------------------------------------------------------------------------------------------
  # Add an asset to a custom portfolio
  # ----------------------------------------------------------------------------------------------------------  
  
  def add_to_custom
    # Pull portfolio out of session
    @corr_matrix  = find_matrix
        
    # Check for empty ticker string
    if invalid_tickers(params[:tickers]) != -1
      flash[:notice] = "You did not enter a valid ticker symbol"
    elsif @corr_matrix.overflowing
      flash[:notice] = "Maximum number of assets has been added"
    else
      # Add a new asset (need to handle case where person doesn't enter ticker)
      tickers       = params[:tickers].upcase.gsub(',',' ').split
      ticker_err    = @corr_matrix.add_many_stocks(tickers, @corr_matrix.period_req)
   
      # Save to session and to database if everything is ok
      if ticker_err.nil?
        save_port_to_db(@corr_matrix)
      else
        flash[:notice] = ticker_err.upcase + " has insufficient history"
      end 
    end
    
    render(:template => 'user/custom.rhtml')
  end
  
  # ----------------------------------------------------------------------------------------------------------
  # Remove an asset from a custom portfolio
  # ----------------------------------------------------------------------------------------------------------  
  
  def remove_from_custom
    # 1) Pull portfolio out of session
    @portfolio    = find_portfolio
    @corr_matrix  = find_matrix
    
    # 2) Remove asset from portfolio
    @corr_matrix.remove_stock( params[:ticker] )
    
    # 3) Save to session and to database
    save_port_to_db(@corr_matrix)
    
    render(:template => 'user/custom.rhtml')
  end
  
  # ----------------------------------------------------------------------------------------------------------
  # Scatter plot for efficient frontier
  # ----------------------------------------------------------------------------------------------------------  
  
  def efficient_frontier
           
    @page_title = "Risk vs Return : The Efficient Frontier"             

    @query = quantalign(params[:period].to_i)
    if @query < 30 then @query = 366 end    
    session[:query] = @query     
  end  
    
  
  # ----------------------------------------------------------------------------------------------------------
  # Relationship between StdDev and Intra-portfolio Correlation
  # ----------------------------------------------------------------------------------------------------------  
  
  def corr_vs_risk
           
    # Create graph data object
    chart_data   = Array.new
    
    # Pull portfolios out of database
    query = quantalign(params[:period].to_i)
    if query < 30 then query = 31 end
    
    @portfolios = Portfolio.find(:all, :conditions => ["period = ?", query])    
    logger.info("== Querying database for portfolios with period  : #{query}")
    logger.info("== Number of portfolios found that match criteria: #{@portfolios.length}")
  
    # Strip out risk and correlation and remove portfolios with too few assets
    @portfolios.each { |x|
      if ( num_assets_in_string(x.tickers) > 4 )
        chart_data  << x.std_dev
        chart_data  << x.intra_corr
      end
    }
        
    # Put chart data into session
    session[:risk_data] = chart_data    
  end    
    
  # ----------------------------------------------------------------------------------------------------------
  # Correlation over Time
  #
  # Inputs: 
  #   ["ticker1", "ticker2"]  - two tickers in a string (converted to an array in this function
  #   period                  - length of time eg. 5 years
  #   interval                - number of days over which to calculate rolling correlation eg. 90 days
  # Output: A cool graph
  # ----------------------------------------------------------------------------------------------------------
    
  def corr_time
    
    if params[:tickers].nil?
      render(:template=>'user/enter_time_corr.rhtml')
      return
    else
      @tickers  = params[:tickers].upcase.gsub(',',' ').split
      period    = params[:period].to_i
      interval  = 63 #  3 month interval = 252 / 4 = 63
    end


    if (@tickers.size != 2)
      flash[:notice] = "You must enter two ticker symbols eg: CSCO MSFT"
      render(:template=>'user/enter_time_corr.rhtml')
      return
    end   
   
    if (invalid_tickers(@tickers.join(" ")) != -1)
      flash[:notice] = invalid_tickers(@tickers.join(" ")) + " is not a valid ticker symbol"
      render(:template=>'user/enter_time_corr.rhtml')
      return
    end
    
    
    @company_names = Array.new
    @company_names = tickers_to_names(@tickers)
   
    @x = Correlation_time.new(@tickers, period, interval)
    corr_series = @x.get_correlation_over_time    
    
    if (corr_series.length<5)
      flash[:notice] = "Those two assets do not have a long enough trading history for meaningful comparison"
      render(:template=>'user/enter_time_corr.rhtml')
      return
    end
    
    
    # Build Chart 
    chart_data   = Array.new
    x_data       = Array.new
    
    # Create X-axis labels
    sd            = ParseDate::parsedate(@x.start_date) 
    start_date    = Date.new(sd[0], sd[1], sd[2])
    @period       = (Date.today - start_date).to_i    

    step_size   = (Date.today - start_date)/corr_series.length 
    for i in 0...corr_series.length
       x_data << (start_date + i * step_size).to_s[0..6]
    end    

    # Build up chart data object to pass to Ziya
    chart_data << corr_series
    chart_data << x_data
    chart_data << @tickers

    
    # Put chart data into session
    session[:ziyadata]  = chart_data
    
  end
  
  # ----------------------------------------------------------------------------------------------------------
  # Correlation matrix for 30 min asset allocation strategy
  # ---------------------------------------------------------------------------------------------------------- 

  def simple_asset_allocation
    # 1) Locate list of tickers to create matrix
    if params[:id].nil? 
      @period=365
    else 
      @period=params[:id].to_i 
    end
    tickers   =  %w{VV VO VB VWO EFA VNQ AGG GSG}
    @page_title = "Simple Asset Allocation"    
    
        
    # 2) Build correlation matrix
    @corr_matrix = Correlation_matrix.new(@period)
    @corr_matrix.add_many_stocks(tickers, @period) 
    
    # 3) Request a StandardQuote to get the company names
    quote_type = YahooFinance::StandardQuote
    @quotes     = YahooFinance::get_quotes( quote_type, tickers ) 
    
    @quotes['VV'   ].name = "US Large Cap Stocks"   
    @quotes['VO'   ].name = "US Mid Cap Stocks"
    @quotes['VB'   ].name = "US Small Cap Stocks"
    @quotes['VWO'  ].name = "Emerging Markets"
    @quotes['EFA'  ].name = "Europe, Australasia, Far East"
    @quotes['VNQ'  ].name = "US Real Estate"
    @quotes['AGG'  ].name = "US Bonds"
    @quotes['GSG'  ].name = "Commodities Index"    
  end

  # ----------------------------------------------------------------------------------------------------------
  # Do we need this....only to handle errors (?)
  # ----------------------------------------------------------------------------------------------------------  
  def enter_custom_port
    @port = Portfolio.new
  end
  
  # ----------------------------------------------------------------------------------------------------------
  # Save portfolio to database and to session
  # ----------------------------------------------------------------------------------------------------------  
  def save_port
    @port = Portfolio.new(params[:portfolio])
    if @port.save # We need to calculate the matrix (after adding portfolio to session)
      session[:portfolio] = @port
      redirect_to :action => :custom
    else # display a nice error message and return to home
      flash[:notice] = "Couldn't save custom portfolio - Did you enter a unique name?"
      render :action => :enter_custom_port
    end
  end

  # ----------------------------------------------------------------------------------------------------------
  # Do we need this....only seems to be needed for redirects
  # ----------------------------------------------------------------------------------------------------------  
  def load_port
    @portfolio = Array.new
  end  
 
  # ----------------------------------------------------------------------------------------------------------
  # Save loaded portfolio to session and recalculate matrix
  # ----------------------------------------------------------------------------------------------------------  
  def loadcalc
    @port = Portfolio.find(params[:id])
    session[:portfolio] = @port
    redirect_to :action => :custom
  end   
  
  # ----------------------------------------------------------------------------------------------------------
  # Search for Portfolio from Database
  # ----------------------------------------------------------------------------------------------------------  
  def search_ports
    
    query = params[:search]
    @portfolio = Portfolio.find(:all, :conditions => ["username = ?", query])

    render :partial => 'search_results', :layout=>false    
  end
  

  # ----------------------------------------------------------------------------------------------------------
  # Check for errors in custom portfolio entry
  # ----------------------------------------------------------------------------------------------------------  
  def feedback
    ticker_string = params[:tickers]
 
    # check for nil ticker string - not sure how this would happen but it occasionally has
    if (ticker_string.nil?) 
      @feedback = ''
    else
      ticker_check  = invalid_tickers(ticker_string)
      
      if ticker_check.nil?
        @feedback = ''
      elsif (ticker_check != -1)
        @feedback = 'Invalid ticker : ' + ticker_check
      else
        @feedback = ''
      end
    end
    
    render :partial=>'feedback', :layout=>false
  end

  private
  
  # ----------------------------------------------------------------------------------------------------------
  # Get correlation matrix out of session. If it doesn't exist, create a new object
  # ----------------------------------------------------------------------------------------------------------  
  def find_matrix
    session[:matrix] ||= Correlation_matrix.new(30)
  end
  
end
