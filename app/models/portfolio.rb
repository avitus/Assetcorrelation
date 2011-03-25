class Portfolio < ActiveRecord::Base

# Structure
#
#     username,     :string
#     tickers,      :string
#     period,       :integer
#     std_dev,      :decimal
#     intra_corr,   :decimal
#     port_ret,     :decimal
  
  def self.show_portfolios(sort_order)
    case sort_order
      when "username"
        find(:all, :order => "username")
      when "period"
        find(:all, :order => "period")
      when "port_ret"
        find(:all, :order => "port_ret DESC")        
      when "created_at"
        find(:all, :order => "created_at DESC")
      when "updated_at"
        find(:all, :order => "updated_at DESC")
      when "std_dev"
        find(:all, :order => "std_dev ASC")  
      when "intra_corr"
        find(:all, :order => "intra_corr ASC")          
      else
        find(:all, :order => "updated_at DESC")
      end
  end  
  
  validates_presence_of       :username, :tickers, :period
  validates_numericality_of   :period
  validates_uniqueness_of     :username  
  
  
  private
  
end
