# To do list
# ~~~~~~~~~~

# Change log
# ~~~~~~~~~~


class MacrovalController < ApplicationController

  def index
    
  end
 
  # ----------------------------------------------------------------------------------------------------------
  # Show Entire Database
  # Inputs:   
  # Outputs:  
  # ----------------------------------------------------------------------------------------------------------  
  def show_db
    @db = Macroval.all
  end
  
  # ----------------------------------------------------------------------------------------------------------
  # Main Dashboard
  # Inputs:   
  # Outputs:  
  # ----------------------------------------------------------------------------------------------------------  
  def dashboard
    
    
    equity_risk_yield_ranges  = [-5, -2, 0, 2, 4, 6, 9, 16] # min = -4.38, max = 14.88
    pe_ten_year_ranges        = [4, 10, 15, 20, 25, 30, 35, 45] # min = 4.78, max = 44.2
    
    # ===== Get today's S&P500 price ====

    
    
    # ===== Equity Risk Yield Table =====
    @equity_risk_yield_table = Array.new
    @equity_risk_yield_headings = ['Range', 'Return', 'Months']
    
    for i in 0...equity_risk_yield_ranges.size-1
      
      range_start = equity_risk_yield_ranges[i]
      range_end   = equity_risk_yield_ranges[i+1]

      logger.debug("*** Querying database for equity risk yield values in range: #{range_start..range_end}")
      dataset     = Macroval.find_equity_risk_yield(range_start..range_end)
      logger.debug("*** Retrieved #{dataset.size} records")
      
      table_row             = Hash.new
      table_row[:range]     = range_start.to_s + " - " + range_end.to_s
      table_row[:mo_ret]    = 100 * (dataset.collect(&:monthly_return).collect(&:to_f).collect { |r| 1 + r/100 }.geometric_mean - 1)
      table_row[:mo_count]  = dataset.size
      
      @equity_risk_yield_table << table_row
      
    end
    
    # ===== PE Table =====
    @pe_ten_year_table = Array.new
    @pe_ten_year_headings = ['Range', 'Return', 'Months']
    
    for i in 0...pe_ten_year_ranges.size-1
      
      range_start = pe_ten_year_ranges[i]
      range_end   = pe_ten_year_ranges[i+1]

      dataset     = Macroval.find_pe(range_start..range_end)
      
      table_row             = Hash.new
      table_row[:range]     = range_start.to_s + " - " + range_end.to_s
      table_row[:mo_ret]    = 100 * (dataset.collect(&:monthly_return).collect(&:to_f).collect { |r| 1 + r/100 }.geometric_mean - 1)
      table_row[:mo_count]  = dataset.size
      
      @pe_ten_year_table << table_row
      
    end   
  end
  
  
  # ----------------------------------------------------------------------------------------------------------
  # Generate all calculated columns - long latency
  # Inputs:   
  # Outputs:  
  # ----------------------------------------------------------------------------------------------------------  
  def calculate_cols
    Macroval.calculate_all_columns
    redirect_to :action => :dashboard
  end
  
  
  # ----------------------------------------------------------------------------------------------------------
  # Interactive Database Filter
  # Inputs:   
  # Outputs:  
  # ----------------------------------------------------------------------------------------------------------  
  def interactive
    @db = Macroval.all(:limit => 10)
  end  
  
  # ----------------------------------------------------------------------------------------------------------
  # Interactive Database Filter
  # Inputs:   
  # Outputs:  
  # ----------------------------------------------------------------------------------------------------------  
  def filter_db
    
    start         = params[:start]
    finish        = params[:finish]
    search_field  = params[:search_on][:field]
    sort_field    = search_field == "year_month" ? "pe_tenyear" : search_field
    
    @db = Macroval.find(:all, :conditions => {"#{search_field}" => start..finish}, :limit => 24, :order => "#{sort_field} ASC")
    
    render :partial => 'macroval', :layout=>false 
  end  
  
  # ----------------------------------------------------------------------------------------------------------
  # Add recent Shiller data
  # Inputs:   
  # Outputs:  
  # ----------------------------------------------------------------------------------------------------------  
  def add_latest_data
    @db =  Macroval.find_year_month(2009..2020)
  end  
  
  # ----------------------------------------------------------------------------------------------------------
  # Add recent Shiller data
  # Inputs:   
  # Outputs:  
  # ----------------------------------------------------------------------------------------------------------  
  def add_month_to_db
    
    year, month = Macroval.most_recent_month
    
    logger.info("*** Latest data in DB is for year #{year} and month #{month}")
       
       
    new_month = (month == 12) ? 1       : month+1
    new_year  = (month == 12) ? year+1  : year
    
    logger.info("*** Trying to add new data for year #{new_year} and month #{new_month}")
    
    Macroval.create( :year_month => new_year+new_month.to_f/100 )
    
    logger.info("*** New month added to dataset.")
    logger.info("Last month is: #{Macroval.last.year_month}")    
        
    redirect_to :action => 'add_latest_data'
    
  end    
  
  # ----------------------------------------------------------------------------------------------------------
  # In place editing support
  # ----------------------------------------------------------------------------------------------------------    
  def update_month
    month_id, field = params[:id].split('-')
    new_data        = params[:value] # need to clean this up with hpricot or equivalent

    @month    = Macroval.find(month_id)
    
    # http://stackoverflow.com/questions/300705/variables-in-ruby-method-names
    @month.send("#{field}=".to_sym, new_data)

    @month.save
    render :text => new_data
  end    
  
end
