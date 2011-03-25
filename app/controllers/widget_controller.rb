class WidgetController < ApplicationController

  session :off

  require 'rubygems'
  require 'yahoofinance'

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
    tickers   =  %w{TIP GLD AGG USO GSG VNQ RWX EEM EFA VB VV VO}
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
    @quotes['USO'  ].name = "Oil"
    @quotes['GSG'  ].name = "Commodities Index"
    @quotes['VNQ'  ].name = "US Real Estate"
    @quotes['RWX'  ].name = "International Real Estate" # This fund is most recent: launched March 2nd 2007
    @quotes['EEM'  ].name = "Emerging Markets"
    @quotes['EFA'  ].name = "Europe, Australasia, Far East"
    @quotes['VB'   ].name = "US Small Cap Stocks"
    @quotes['VV'   ].name = "US Large Cap Stocks"   
    @quotes['VO'   ].name = "US Mid Cap Stocks"   
    
  end
  
  
  # ----------------------------------------------------------------------------------------------------------
  # Custom portfolio entry
  # ----------------------------------------------------------------------------------------------------------  
  def custom
    # 1) Create portfolio from parameters submitted from widget form
    @portfolio = Portfolio.new(params[:portfolio])
                
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
        
    # 5) Write internal correlation coefficient and standard deviation to database
    save_port_to_db(@corr_matrix)
      
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
  
  
end
            