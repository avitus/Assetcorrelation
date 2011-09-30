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

class CorrelationController < ApplicationController

	require 'yahoofinance'

  caches_page :correlations, :countries, :sectors, :bonds, :simple_asset_allocation
  
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
  	
    @tab = "corr" 
    @sub = "all"  	
  	
    # 1) Locate list of tickers to create matrix
    if params[:id].nil? 
      @period=91
    else 
      @period=[params[:id].to_i, 731].min 
    end
    tickers   =  %w{TIP GLD AGG EMB USO GSG VNQ RWX EEM EFA VB VV VO}
    @page_title = "Asset Correlations: Major Asset Classes"    
    
        
    # 2) Build correlation matrix
    @corr_matrix = Correlation_matrix.new(@period)
    @corr_matrix.add_many_stocks(tickers) 
    
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

    @tab = "corr" 
    @sub = "countries"    	
  	
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
    @corr_matrix.add_many_stocks(tickers) 
    
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
  	
    @tab = "corr" 
    @sub = "sectors"  
      	
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
    @corr_matrix.add_many_stocks(tickers) 
    
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

    @tab = "corr" 
    @sub = "bonds"    	
  	
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
    @corr_matrix.add_many_stocks(tickers) 
    
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
  # Correlation matrix for a user portfolio
  # ---------------------------------------------------------------------------------------------------------- 
  def custom
    @portfolio = Portfolio.find(params[:portfolio])
    @period    = params[:period] || 90
    
    tickers    = @portfolio.assets.map { |asset| asset.ticker }
    
    # 2) Build correlation matrix
    @corr_matrix = Correlation_matrix.new(@period.to_i)
    @corr_matrix.add_many_stocks(tickers)     
    
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
    Rails.logger.info("== Querying database for portfolios with period  : #{query}")
    Rails.logger.info("== Number of portfolios found that match criteria: #{@portfolios.length}")
  
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


  private

  
end
