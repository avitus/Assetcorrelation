class AdminController < ApplicationController

  # ----------------------------------------------------------------------------------------------------------
  # What does this bit of code do??
  # ----------------------------------------------------------------------------------------------------------
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  # ----------------------------------------------------------------------------------------------------------
  # Administrative Home Page
  # ----------------------------------------------------------------------------------------------------------
  def index
    @portfolios = Portfolio.show_portfolios(params[:sort_order])    
  end

  # ----------------------------------------------------------------------------------------------------------
  # List All Portfolios
  # ----------------------------------------------------------------------------------------------------------
  def list_ports
    @portfolios = Portfolio.show_portfolios(params[:sort_order])
  end
  
  # ----------------------------------------------------------------------------------------------------------
  # List All Assets
  # ----------------------------------------------------------------------------------------------------------
  def list_assets
    @assets = Asset.show_assets(params[:sort_order])
  end  
 
  
  # ----------------------------------------------------------------------------------------------------------
  # Update all portfolios -- takes a long time and a lot of CPU cycles
  # ----------------------------------------------------------------------------------------------------------  
  def update_all
    
    if ( !params[:period].nil? )
      @portfolios = Portfolio.find(:all, :conditions => ["period = ?", params[:period]])
    else
      @portfolios = Portfolio.find(:all, :order => "updated_at")     
    end
    
    logger.info("================= Updating #{@portfolios.size} portfolios at #{Time.now} ================== ")      
    logger.info("|")
    # Strip out risk and return
    @portfolios.each { |x|
      logger.info("| #{x.username} #{x.period} #{x.tickers} ")
      if ( num_assets_in_string(x.tickers) < 2 ) or ( num_assets_in_string(x.tickers) > 20 )
        # Delete portfolio
        logger.info("| ** Deleting portfolio: #{x.username}")
        Portfolio.find(x.id).destroy   # This is a fairly destructive line of code :)      
      elsif (Time.now - x.updated_at) < (3*60*60)  # skip if updated less than 3 hours ago       
        logger.info("| ** Skipping: #{x.username}. Last update was at #{x.updated_at}")
      else
        get_port_current(x)        
      end

    }    
    redirect_to :action => 'db_stats'
  end
  

  # ----------------------------------------------------------------------------------------------------------
  # Add tickers for all portfolios to the asset database
  # ----------------------------------------------------------------------------------------------------------  
  def add_all_ports_to_asset_db
          
    portfolios = Portfolio.find(:all)
    
    logger.info("================= Processing assets for #{portfolios.size} portfolios at #{Time.now} ================== ")      
    logger.info("|")      
     
    portfolios.each { |x|
      add_tickers_to_asset_db(x)
      logger.info("| ** Processing tickers for portfolio: #{x.username}")
    } 
    redirect_to :action => 'db_stats'
  end
 
  # ----------------------------------------------------------------------------------------------------------
  # Add tickers for a single portfolio to the asset database
  # ----------------------------------------------------------------------------------------------------------  
  def add_tickers_to_asset_db(portfolio)

    # Convert ticker string to array
    tickers = portfolio.tickers.upcase.gsub(',',' ').split
    period  = align_period(portfolio)    

    # Build asset information
    tickers.each { |t|
      
      # Check database for existing record
      a = Asset.find(:first, :conditions => ["ticker = ?", t])
      
      if a.nil?
        Asset.new { |a|
        a.ticker        = t
        a.name          = ticker_to_name(t)
        a.avail_history = period
        a.port_count    = 1
        logger.info("| ======= Adding new asset:[#{t}] #{a.name}")
        a.save
        }
      else
        a.port_count    += 1
        # We need to do an update
        if period>a.avail_history
          a.avail_history = period
          a.save
        end
      end      
    } 
  end
  
  # ----------------------------------------------------------------------------------------------------------
  # Portfolio database statistics
  # ----------------------------------------------------------------------------------------------------------   
  def db_stats
   
   # -----------Portfolio Database Statistics ----------     
    @port_size        = Hash.new(0)
    @stats            = Hash.new(0)
    @quantized_ports  = @non_quantized_ports = 0
    @valid_periods    = [31, 91, 183, 366, 731, 1826, 3652, 7304]
    
    # Start with oldest portfolio ie. the one updated longest ago
    @allports = Portfolio.find(:all, :order => "updated_at")
    
    @allports.each { |port|
    
      # Stats for time periods
      period = port.period.to_i
      @stats[period] += 1
      
      # Stats for portfolio size
      @port_size[num_assets_in_string(port.tickers)] += 1
    }
    
   @valid_periods.each { |x| @quantized_ports += @stats[x] }
   @non_quantized_ports = @allports.length - @quantized_ports

   # -----------Asset Database Statistics ---------- 

   @asset_stats = Hash.new(0)
   
   allassets = Asset.find(:all)
   
   @num_assets = allassets.length
   
   allassets.each  { |asset|
     @valid_periods.each { |p| 
       if asset.avail_history >= p 
         @asset_stats[p] += 1
       end
     }
   }   
    
    
  end
  
  # ----------------------------------------------------------------------------------------------------------
  # Update Valid Trading Days
  # ----------------------------------------------------------------------------------------------------------   
  def create_valid_trading_days
    
    File.open("invalid_trade_dates.txt", "w") do |file|
      file.puts "Invalid trade dates for past two decades"
      file.puts "Generated: " + Date.today.to_s
    end  
    
    File.open("valid_trade_dates.txt", "w") do |file|
      file.puts "Valid trade dates for past two decades"
      file.puts "Generated: " + Date.today.to_s
    end     
    
    logger.info("| *** Calculating valid trading days")
    logger.info("| *** #{Time.now} Getting history for all assets")    
    traded = Hash.new(0)
    
    allassets = Asset.find(:all)
    
    allassets.each { |asset| 
      
      # Get historical quotes for the last twenty years
      h = asset.ping_yahoo(7304)
      
      # Add trading days to a histogram
      h.each { |day|
        traded[ day[0] ] += 1
      }      
    }
    
    # Determine which days are valid trading days - start with earliest date
    logger.info("| *** #{Time.now} Determining missing trading days")    
    stocks_traded_previous_day = 0
    traded.sort.each { |day|
      if day[1] < (stocks_traded_previous_day/2)
        # This is not a valid trading day in the US - write that to file
        logger.info("| #{day[0]} is not a valid trading day. Only #{day[1]} stocks traded that day")
        File.open("invalid_trade_dates.txt", "a") do |file|
          file.puts day[0]
        end
      elsif day[1] < stocks_traded_previous_day
        # This day is a US trading day but some stocks didn't trade that day
        logger.info("| #{day[0]} is not a valid trading day. #{stocks_traded_previous_day - day[1]} stocks didn't trade that day")        
      else
        # Probably ok - it could just be by chance though
        File.open("valid_trade_dates.txt", "a") do |file|
          file.puts day[0]
        end        

      end
      stocks_traded_previous_day = day[1] 
    }
    logger.info("| *** #{Time.now} Done")     
    
    redirect_to :action => 'db_stats'
    
  end

  
  # ----------------------------------------------------------------------------------------------------------
  # Update portfolio
  # ----------------------------------------------------------------------------------------------------------  
  def update_port

    @portfolio = Portfolio.find(params[:id])
    # session[:portfolio] = @portfolio

    get_port_current(@portfolio)
    add_tickers_to_asset_db(@portfolio)
    
    redirect_to :action => 'index'
  end
 
  # ----------------------------------------------------------------------------------------------------------
  # Recalculate portfolio data for period ending today
  # ----------------------------------------------------------------------------------------------------------   
  def get_port_current(portfolio)
    tickers = portfolio.tickers.upcase.gsub(',',' ').split      
    period = align_period(portfolio)
    
    # Check for invalid tickers - due to companies folding etc
    if (bad_ticker = invalid_tickers(portfolio.tickers)) != -1
      logger.info("| ** Removing invalid ticker: #{bad_ticker}")
      # We should remove from asset database as well
      if !(a = Asset.find(:first, :conditions => ["ticker = ?", bad_ticker])).nil?
        logger.info("| ** Located and destroying #{a.name}")
        a.destroy
      end
      
      # And then remove from ticker string
      tickers.delete(bad_ticker) { 
        logger.info("| ** Ouch! - couldn't locate ticker") 
        return -1 # This shouldn't ever happen 
      }
    end
        
    # Build correlation matrix
    corr_matrix = Correlation_matrix.new(period)
    ticker_err  = corr_matrix.add_many_stocks(tickers, period)
    
    if (!ticker_err.nil?)
      logger.info("| ** Ticker error: #{ticker_err}")
    end

    
    # Write internal correlation coefficient and standard deviation to database
    # result = save_port_to_db(@corr_matrix) # requires portfolio to be saved in session
    result = save_matrix_data_to_port(corr_matrix, portfolio)
    if (!result)
      logger.info("| ** Portfolio was not saved")
    end
  end

  # ----------------------------------------------------------------------------------------------------------
  # Delete a portfolio for all time
  # ---------------------------------------------------------------------------------------------------------- 
  def destroy_port
    Portfolio.find(params[:id]).destroy
    redirect_to :action => 'index'
  end  
  
  private
   
  # ----------------------------------------------------------------------------------------------------------
  # Quantize the period
  # ---------------------------------------------------------------------------------------------------------- 
  def align_period(portfolio)
    valid_periods = [31,91,183,366,731,1826,3653]
    period        = portfolio.period
    added_days    = 0
    
    if ( !valid_periods.include?(period) )  # ie. period is not already quantized 
      updated_date = portfolio.updated_at
      # Add one additional day to quantize portfolio's quicker
      # Once everything is quantized we can remove the +1
      days_elapsed = ((Time.now - updated_date) / 86400).round + 1 # 86400 = number of seconds per day
      # logger.debug("=== Updated date is: #{updated_date}")
      # logger.debug("=== Time now is    : #{Time.now}")
      # logger.debug("=== Days elapsed is: #{days_elapsed}")
      
      # Extend the period
      valid_periods.each { |vp|
        if (added_days==0 and period<vp) # ie. we've not already figured out how many days to add
          # logger.debug("=== Checking period: #{vp}")
          if period + days_elapsed < vp
            added_days = days_elapsed
          else
            added_days =  vp-period
            # logger.debug("===== Setting to quantization level: #{vp}")
          end
        end
      }
      # logger.debug("=== Old period is: #{period}")
      # logger.debug("=== Adding       : #{added_days}")
      period += added_days
      # logger.debug("=== New period is: #{period}")
    
      
    # === This section deals with portfolios that are already quantized ===
    else
      created_date = portfolio.created_at
      days_elapsed = ((Time.now - created_date) / 86400).to_i # 86400 = number of seconds per day
      
      # Move up to next quantum level
      valid_periods.each { |vp|
        if days_elapsed > vp
          period = vp
          logger.debug("=== Updating period to next quantum level: #{vp}")
        end
      }
      
    end
    return period
  end  

end
