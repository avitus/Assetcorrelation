class Asset < ActiveRecord::Base

# Structure
#
#     name,           :string
#     ticker,         :string
#     port_count,     :integer
#     avail_history,  :integer  --- number of days of available history
#     first_traded,   :date
#     daily_vol       :decimal, :precision => 5, :scale => 2  --- expected daily volatility
#     daily_ret       :decimal, :precision => 5, :scale => 2  --- expected daily return
  
  def self.show_assets(sort_order)
    case sort_order
      when "name"
        find(:all, :order => "name")
      when "ticker"
        find(:all, :order => "ticker")
      when "port_count"
        find(:all, :order => "port_count DESC")
      when "avail_history"
        find(:all, :order => "avail_history")
      when "first_traded"
        find(:all, :order => "first_traded")
      when "daily_vol"
        find(:all, :order => "daily_vol")
      when "daily_ret"
        find(:all, :order => "daily_ret")
      when "created_at"
        find(:all, :order => "created_at DESC")  
      when "updated_at"
        find(:all, :order => "updated_at DESC")          
      else
        find(:all, :order => "name")
      end
  end  
  
  
  def self.random
    # query for example purposes only -- 
    # ordering by rand() is slow, see here: 
    # http://jan.kneschke.de/projects/mysql/order-by-rand
    uncached do 
      find(:first, :order => "rand()") 
    end
  end
  
  
  # ----------------------------------------------------------------------------------------------------------
  # Get price history from Yahoo
  # Inputs:   number of days of price history
  # Outputs:
  # ----------------------------------------------------------------------------------------------------------   
  def ping_yahoo(period_req)

    # Request an historical quote from Yahoo server
    # Yahoo returns only trading days of data
    h = YahooFinance::get_historical_quotes_days(self.ticker.upcase, period_req)

  end  
   
  validates_presence_of       :name, :ticker
  validates_uniqueness_of     :ticker
  
end
