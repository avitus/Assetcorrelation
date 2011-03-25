class ChartController < ApplicationController

  helper Ziya::HtmlHelpers::Charts
  helper Ziya::YamlHelpers::Charts
  
  # Callback from the flash movie to get the chart's data
  # Uses line_chart.yml for style

  # ----------------------------------------------------------------------------------------------------------
  # Line plot for correlation over time
  # ----------------------------------------------------------------------------------------------------------
  
  def load_chart

    y_data  = Array.new
    x_data  = Array.new
    tickers = Array.new
     
    y_data  = session[:ziyadata][0]
    x_data  = session[:ziyadata][1]
    tickers = session[:ziyadata][2]
    
    title = "Correlation between " + tickers[0] + " and " + tickers[1]
    
    logger.debug("** Length of y_axis series: #{y_data.length}")
    logger.debug("** Length of x-axis series: #{x_data.length}")      
    
    skip = x_data.length / 9
     
    chart = Ziya::Charts::Line.new('JTAKAPG3AJ2O.945CWK-2XOI1X0-7L')
    chart.add( :axis_category_text, x_data )
    chart.add( :user_data, :skip, skip )
    chart.add( :series, title, y_data )
    chart.add( :theme , "assetcorrelation" )    
    
    respond_to do |fmt|
      fmt.xml { render :xml => chart.to_xml }
    end
  end
  
  # ----------------------------------------------------------------------------------------------------------
  # Scatter plot for efficient frontier
  # ----------------------------------------------------------------------------------------------------------  
  
  def load_ef

    xy_data  = Array.new
    custom   = Array.new
    
    # Pull portfolios out of database
    @query = session[:query]
      if @query < 30 then @query = 366 end
    
    @portfolios = Portfolio.find(:all, :conditions => ["period = ?", @query])    
    logger.info("== Querying database for portfolios with period  : #{@query}")
    logger.info("== Number of portfolios found that match criteria: #{@portfolios.length}")
  
    
    if (@portfolios.length < 5)
      flash[:notice] = "There aren't sufficient portfolios for meaningful comparison. Showing one year portfolios instead"
      @portfolios = Portfolio.find(:all, :conditions => ["period = ?", 366])
      logger.info("** Insufficient data: defaulting to one year portfolios")
    end    
    
    # Strip out risk and return: x = Risk, y = Return
    @portfolios.each { |x|
      xy_data  << x.std_dev
      xy_data  << x.port_ret
    }
     
    title = "User-entered portfolios"
        
    chart = Ziya::Charts::Scatter.new('JTAKAPG3AJ2O.945CWK-2XOI1X0-7L')
    chart.add( :axis_category_text, %w[x y]*(xy_data.length/2) )  # Need to make sure there is an argument here
    chart.add( :series, title, xy_data )                      # User entered

    custom   = session[:portfolio]
    if (!custom.nil?)
      stdev    = custom.std_dev
      port_ret = custom.port_ret
      logger.debug("====== Stdev  = #{stdev}")
      logger.debug("====== Return = #{port_ret}")      
      chart.add( :series, "Your Portfolio", [stdev, port_ret])  # Your port
    end     
    
    chart.add( :theme , "assetcorrelation" )    
    
    respond_to do |fmt|
      fmt.xml { render :xml => chart.to_xml }
    end
  end  

           
           

        

    
  
  
  
  
   
  # ----------------------------------------------------------------------------------------------------------
  # Scatter plot for Std Dev vs Intra-portfolio Correlation
  # ----------------------------------------------------------------------------------------------------------  
  
  def load_corr_vs_risk

    xy_data  = Array.new
    custom   = Array.new
    
    xy_data  = session[:risk_data] # x = Risk, y = Intra-port Corr NB: occasionally there is no session data. Not sure why    
   
    title = "User-entered portfolios"
        
    chart = Ziya::Charts::Scatter.new('JTAKAPG3AJ2O.945CWK-2XOI1X0-7L', "scatter_chart_corr_risk")
    chart.add( :axis_category_text, %w[x y]*(xy_data.length/2) )  # Need to make sure there is an argument here
    chart.add( :series, title, xy_data )                          # User entered

    custom   = session[:portfolio]
    if (!custom.nil?)
      stdev      = custom.std_dev
      intra_corr = custom.intra_corr
      logger.debug("====== Stdev  = #{stdev}")
      logger.debug("====== Intra_Port Corr = #{intra_corr}")      
      chart.add( :series, "Your Portfolio", [stdev, intra_corr])  # Your port
    end     
    
    chart.add( :theme , "assetcorrelation" )    
    
    respond_to do |fmt|
      fmt.xml { render :xml => chart.to_xml }
    end
  end    
   
   
end
