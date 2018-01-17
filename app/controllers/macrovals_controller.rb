class MacrovalsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :authorize, :except => [:dashboard, :index]
    
  # GET /macrovals
  # GET /macrovals.json
  def index
 
    @tab = "macro" 
    @sub = "db"   
 
    @macrovals = Macroval.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @macrovals }
    end
  end

  # GET /macrovals/1
  # GET /macrovals/1.json
  def show
    @macroval = Macroval.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @macroval }
    end
  end

  # GET /macrovals/new
  # GET /macrovals/new.json
  def new
    @macroval = Macroval.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @macroval }
    end
  end

  # GET /macrovals/1/edit
  def edit
    @macroval = Macroval.find(params[:id])
  end

  # POST /macrovals
  # POST /macrovals.json
  def create
    @macroval = Macroval.new(params[:macroval])

    respond_to do |format|
      if @macroval.save
        format.html { redirect_to @macroval, notice: 'Macroval was successfully created.' }
        format.json { render json: @macroval, status: :created, location: @macroval }
      else
        format.html { render action: "new" }
        format.json { render json: @macroval.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /macrovals/1
  # PUT /macrovals/1.json
  def update
    @macroval = Macroval.find(params[:id])

    respond_to do |format|
      if @macroval.update_attributes(params[:macroval])
        format.html { redirect_to @macroval, notice: 'Macroval was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @macroval.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /macrovals/1
  # DELETE /macrovals/1.json
  def destroy
    @macroval = Macroval.find(params[:id])
    @macroval.destroy

    respond_to do |format|
      format.html { redirect_to macrovals_url }
      format.json { head :ok }
    end
  end
  
  #------------- ^^ Scaffolding above this line ^^ --------------------------------------------------------
  
  
  # ----------------------------------------------------------------------------------------------------------
  # Show Entire Database
  # Inputs:   
  # Outputs:  
  # ----------------------------------------------------------------------------------------------------------  
  def show_db
  	
    @tab = "macro" 
    @sub = "db"   	
  	
    @db = Macroval.all
  end
  
  # ----------------------------------------------------------------------------------------------------------
  # Main Dashboard
  # Inputs:   
  # Outputs:  
  # ----------------------------------------------------------------------------------------------------------  
  def dashboard
 
    @tab = "macro" 
    @sub = "dash"   
    
    
    equity_risk_yield_ranges  = [-5, -2, 0, 2, 4, 6, 9, 16] # min = -4.38, max = 14.88
    pe_ten_year_ranges        = [4, 10, 15, 20, 25, 30, 35, 45] # min = 4.78, max = 44.2
    
    # ===== Calculate today's Shiller 10 Yr PE Ratio ====

    @quote_type_a  = YahooFinance::StandardQuote
    @quote_type_b  = YahooFinance::ExtendedQuote
    @quote_type_c  = YahooFinance::RealTimeQuote

    @quote_symbols = "^TNX,^GSPC"
    
    # Get the quotes from Yahoo! Finance.  The get_quotes method call
    # returns a Hash containing one quote object of type "quote_type" for
    # each symbol in "quote_symbols".  If a block is given, it will be
    # called with the quote object (as in the example below).
    @quotes      = YahooFinance::get_quotes( @quote_type_a, @quote_symbols )
        
    # Calculate Shiller 10 Yr PE Ratio
		@ten_yr_rate = @quotes['^TNX' ].lastTrade
		@s_and_p		 = @quotes['^GSPC'].lastTrade
    @shiller_pe  = @quotes['^GSPC'].lastTrade / Macroval.last.spcomposite.to_f * Macroval.last.pe_tenyear.to_f 
		@ery				 = 1 / @shiller_pe * 100 - @ten_yr_rate
    
    # ===== Equity Risk Yield Table =====
    @equity_risk_yield_table = Array.new
    @equity_risk_yield_headings = ['Equity Risk', 'Return', 'Months']
    
    for i in 0...equity_risk_yield_ranges.size-1
      
      range_start = equity_risk_yield_ranges[i]
      range_end   = equity_risk_yield_ranges[i+1]

      dataset     = Macroval.find_equity_risk_yield(range_start..range_end)
            
      table_row             = Hash.new
      table_row[:range]     = range_start.to_s + " - " + range_end.to_s
      table_row[:mo_ret]    = 100 * (dataset.collect(&:monthly_return).collect(&:to_f).collect { |r| 1 + r/100 }.geometric_mean - 1)
      table_row[:mo_count]  = dataset.size
      
      @equity_risk_yield_table << table_row
      
    end
    
    # ===== PE Table =====
    @pe_ten_year_table = Array.new
    @pe_ten_year_headings = ['10 Yr P/E', 'Return', 'Months']
    
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
    @db =  Macroval.find_year_month(2010..2020)
  end  
  
  # ----------------------------------------------------------------------------------------------------------
  # Add recent Shiller data
  # Inputs:   
  # Outputs:  
  # ----------------------------------------------------------------------------------------------------------  
  def add_month_to_db
    
    year, month = Macroval.most_recent_month       
       
    new_month = (month == 12) ? 1       : month+1
    new_year  = (month == 12) ? year+1  : year
        
    Macroval.create( :year_month => new_year+new_month.to_f/100 )  
        
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
