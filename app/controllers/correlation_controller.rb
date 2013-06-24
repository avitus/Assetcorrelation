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
  include SecuritiesHelper
	require 'yahoofinance'

  caches_action :correlations, :countries, :sectors, :bonds, :simple_asset_allocation, :expires_in => 12.hours, :layout => false

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
      @period=[params[:id].to_i, 1826].min
    end
    tickers   =  %w{TIP GLD AGG EMB USO GSG VNQ RWX EEM EFA VB VV VO}
    @page_title = "Asset Correlations: Major Asset Classes"


    # 2) Build correlation matrix
    @correlation_matrix = Correlation_matrix.new(@period)
    @correlation_matrix.add_many_stocks(tickers)

    # EMB fund is most recent:Launched Dec 19th, 2007. Be sure to update handling of params (line 97) at start of
    # method if adding longer periods.

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
    @correlation_matrix = Correlation_matrix.new(@period)
    @correlation_matrix.add_many_stocks(tickers)

    # TUR fund is most recent - launched April 1st 2008

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
    @correlation_matrix = Correlation_matrix.new(@period)
    @correlation_matrix.add_many_stocks(tickers)

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
    @correlation_matrix = Correlation_matrix.new(@period)
    @correlation_matrix.add_many_stocks(tickers)

    # EMB Launched Dec 19th, 2007

  end

  # ----------------------------------------------------------------------------------------------------------
  # Correlation matrix for a user portfolio
  # ----------------------------------------------------------------------------------------------------------
  def custom
    @portfolio = Portfolio.find(params[:portfolio])
    @period    = params[:period] || 90

    tickers    = @portfolio.securities.map { |security| security.ticker }

    if tickers.empty?
      flash.notice = 'You have to add assets to your portfolio before we can calculate a correlation matrix'
      redirect_to portfolios_path
    else
      @correlation_matrix = Correlation_matrix.new(@period.to_i)
      shortest_ticker = @correlation_matrix.add_many_stocks(tickers[0..15])
    end

    if tickers.length > 16
      flash.notice = 'Maximum number of assets for which we can calculate a correlation matrix is 16.'
    end

    # We only alert user if difference is more than four days since on a Monday before the closing prices are reported
    # the gap can be four days.
    if shortest_ticker and @correlation_matrix.period_actual < @correlation_matrix.period_req-4
      Rails.logger.debug("Actual    period: #{@correlation_matrix.period_actual}")
      Rails.logger.debug("Requested period: #{@correlation_matrix.period_req}")
      flash.notice = shortest_ticker + " only has a stock history since " + @correlation_matrix.start_date.to_s + ". Shortening period accordingly"
    end

  end

  def time

  end

  # ----------------------------------------------------------------------------------------------------------
  # Correlation over Time
  #
  # Inputs:
  # ["ticker1", "ticker2"] - two tickers in a string (converted to an array in this function
  # period - length of time eg. 5 years
  # interval - number of days over which to calculate rolling correlation eg. 90 days
  # Output: A cool graph
  # ----------------------------------------------------------------------------------------------------------
  def corr_over_time

    if params[:ticker1] and params[:ticker2]
      ticker1 = params[:ticker1].upcase
      ticker2 = params[:ticker2].upcase
      @tickers = Array.[]( ticker1, ticker2 )
      period = params[:period].to_i
      interval = 21 # 3 month interval = 252 / 4 = 63
    else
      return
    end

    if @tickers.ticker_check == true
      logger.debug "Building graph with tickers #{@tickers}"
      @x = Correlation_time.new(@tickers, period, interval)
      corr_series = @x.get_correlation_over_time

      # Build Chart
      chart_data = Array.new
      x_data = Array.new

      # Create X-axis labels
      start_date = @x.start_date
      end_date   = Date.today()

      @period = (Date.today - start_date).to_i

      step_size = (Date.today - start_date)/corr_series.length
      for i in 0...corr_series.length
         x_data << (start_date + i * step_size).to_s
      end

      # Build up chart data object to pass to Ziya
      chart_data << corr_series
      chart_data << x_data
      chart_data << @tickers

      respond_to do |format|
        format.json { render json: chart_data }
      end
    else
      respond_to do |format|
        format.json { render json: {error: "Invalid ticker"}.to_json }
      end
    end
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
