class Macroval < ActiveRecord::Base
#    t.decimal "year_month",        :precision => 10, :scale => 2, :null => false
#    t.decimal "spcomposite",       :precision => 10, :scale => 2
#    t.decimal "dividends",         :precision => 10, :scale => 2
#    t.decimal "earnings",          :precision => 10, :scale => 2
#    t.decimal "cpi",               :precision => 10, :scale => 2
#    t.decimal "date_fraction",     :precision => 10, :scale => 2
#    t.decimal "ten_year_rate",     :precision => 10, :scale => 2
#    t.decimal "price_real",        :precision => 10, :scale => 2
#    t.decimal "dividends_real",    :precision => 10, :scale => 2
#    t.decimal "earnings_real",     :precision => 10, :scale => 2
#    t.decimal "pe_tenyear",        :precision => 10, :scale => 2
#    t.decimal "monthly_return",    :precision => 10, :scale => 2
#    t.decimal "one_yr_return",     :precision => 10, :scale => 2
#    t.decimal "three_yr_return",   :precision => 10, :scale => 2
#    t.decimal "equity_risk_yield", :precision => 10, :scale => 2
#    t.decimal "dividend_yield",    :precision => 10, :scale => 2
#    t.decimal "earnings_yield",    :precision => 10, :scale => 2
#    t.decimal "inflation",         :precision => 10, :scale => 2
  
  validates_presence_of       :year_month
  validates_uniqueness_of     :year_month

  # ----------------------------------------------------------------------------------------------------------
  # Estimate of Current Shiller 10 Yr P/E Ratio
  # ----------------------------------------------------------------------------------------------------------   
  def self.current_pe
      stock_quote('^GSPC') / self.last.spcomposite.to_f * self.last.pe_tenyear.to_f
  end  

  # ----------------------------------------------------------------------------------------------------------
  # Equity Risk Yield 
  # ----------------------------------------------------------------------------------------------------------   
  def self.current_ery
      1 / current_pe - self.last.ten_year_rate.to_f
  end 

  # ----------------------------------------------------------------------------------------------------------
  # Recalculate all additional columns
  # Outputs:  Updates all extra columns
  # ---------------------------------------------------------------------------------------------------------- 

  def self.calculate_all_columns
    
    data = find(:all)
    
    current_cpi = self.last.cpi
    
    if !current_cpi or current_cpi == 0
       flash[:error] = 'Need most recent CPI to calculate real dividends'
       return
    end

    for i in 0...data.size # exclude final value
      
      # Set 10 Yr PE's that are zero to nil instead
      if data[i].pe_tenyear == 0  
        data[i].pe_tenyear = nil
      end

      if data[i].dividends == 0 or !data[i].dividends
        data[i].dividends       = nil
        data[i].dividends_real  = nil
      end      

      if data[i].earnings == 0 or !data[i].earnings
        data[i].earnings        = nil
        data[i].earnings_real   = nil
      end

      if data[i].ten_year_rate == 0  
        data[i].ten_year_rate   = nil
      end
      
      # Calculate real S&P Price, Earnings and Dividends
      discount_factor = current_cpi / data[i].cpi
      
      data[i].price_real      = data[i].spcomposite       * discount_factor
      data[i].dividends_real  = (data[i].dividends || 0)  * discount_factor # set to zero if not yet reported
      data[i].earnings_real   = (data[i].earnings  || 0)  * discount_factor # set to zero if not yet reported
      
      # Calculate 10 Yr Shiller PE
      if i >= 120
        avg_decade_earnings = 0
        for month in 1..120
          avg_decade_earnings += data[i-month].earnings_real / 120  # start with prior month
        end
        data[i].pe_tenyear     = data[i].price_real / avg_decade_earnings        
      else
        data[i].pe_tenyear     = nil
      end
     
      
      if data[i+1] and data[i+1].price_real and data[i].dividends
        # Calculate monthly return (and annualize) - dividends are ANNUAL dividends in DB     
        data[i].monthly_return    = ((1+(data[i+1].price_real - data[i].price_real + data[i].dividends_real/12) / data[i].price_real)**12-1) * 100
      end
        
      # Calculate earnings yield
      data[i].earnings_yield    = data[i].pe_tenyear ? 1 / data[i].pe_tenyear * 100 : nil

      # Calculate dividend yield
      data[i].dividend_yield    = data[i].dividends_real ? data[i].dividends_real / data[i].price_real * 100 : nil      
      
      # Calculate equity risk yield
      data[i].equity_risk_yield = (data[i].earnings_yield and data[i].ten_year_rate) ? data[i].earnings_yield - data[i].ten_year_rate : nil
      
      # Calculate inflation rate -- smooth over three months
      if i>=3
        data[i].inflation         = ((data[i].cpi / data[i-3].cpi) ** 4 - 1) * 100
      else
        data[i].inflation         = nil
      end
      
      
      # Save month to database
      data[i].save
    end
  end
  
  # ----------------------------------------------------------------------------------------------------------
  # Search database for a range of ten year PE ratios
  # Inputs:   range eg. 10..15
  # Outputs:  array of all objects that meet criteria
  # ----------------------------------------------------------------------------------------------------------   
  def self.find_pe(range, options = {})  
    with_scope :find => options do  
      find_all_by_pe_tenyear(range, :order => 'pe_tenyear DESC')  
    end  
  end  
  
  # ----------------------------------------------------------------------------------------------------------
  # Search database for a range of equity risk yields
  # Inputs:   range eg. 10..15
  # Outputs:  array of all objects that meet criteria
  # ----------------------------------------------------------------------------------------------------------   
  def self.find_equity_risk_yield(range, options = {})  
     with_scope :find => options do  
       find_all_by_equity_risk_yield(range, :order => 'equity_risk_yield DESC')  
     end  
  end    

  # ----------------------------------------------------------------------------------------------------------
  # Search database for a range of equity risk yields
  # Inputs:   range eg. 10..15
  # Outputs:  array of all objects that meet criteria
  # ----------------------------------------------------------------------------------------------------------   
  def self.find_year_month(range, options = {})  
     with_scope :find => options do  
       find_all_by_year_month(range)  
     end  
  end    
  
  # ----------------------------------------------------------------------------------------------------------
  # Return most recent month of data
  # Outputs:  [2009, 11]
  # TODO: 2009.10 (Oct) is being returned as Jan because .10 -> 0.1 -> 1 (instead of 10)
  # ---------------------------------------------------------------------------------------------------------- 
  def self.most_recent_month
    year, month = self.last.year_month.to_s.split('.')
    
    month_index = case month
      when "0"  then  0
      when "01" then  1
      when "02" then  2
      when "03" then  3
      when "04" then  4
      when "05" then  5
      when "06" then  6
      when "07" then  7
      when "08" then  8
      when "09" then  9
      when "1"  then 10
      when "11" then 11
      when "12" then 12
      else -1 # error condition
    end
    
    return year.to_i, month_index.to_i
  end
  
end


# Monthly dividend and earnings data are computed from the S&P four-quarter tools for the quarter since 1926, 
# with linear interpolation to monthly figures. Dividend and earnings data before 1926 are from Cowles and 
# associates (Common Stock Indexes, 2nd ed. [Bloomington, Ind.: Principia Press, 1939]), interpolated from annual data. 
# Stock price data are monthly averages of daily closing prices through January 2000, the last month available 
# as this book goes to press. The CPI-U (Consumer Price Index-All Urban Consumers) published by the 
# U.S. Bureau of Labor Statistics begins in 1913; for years before 1913 1 spliced to the CPI Warren and Pearson's 
# price index, by multiplying it by the ratio of the indexes in January 1913. December 1999 and January 2000 values 
# for the CPI-Uare extrapolated. See George F. Warren and Frank A. Pearson, Gold and Prices (New York: John Wiley and 
# Sons, 1935). Data are from their Table 1, pp. 11–14. For the Plots, I have multiplied the inflation-corrected series 
# by a constant so that their value in january 2000 equals their nominal value, i.e., so that all prices are effectively 
# in January 2000 dollars.