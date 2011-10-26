class Array
  # ----------------------------------------------------------------------------------------------------------
  # Check whether array of tickers is valid
  # Input: ["msft", "ABC", "CSCO", "xyz"]                 -- an array of ticker symbols
  # Output: true or ["ABC","XYZ"] -- an array of the invalid tickers
  # ----------------------------------------------------------------------------------------------------------   
  def ticker_check
          
    invalid_tickers = self.select { |t| !Security.exists?(:ticker => t.upcase) }    
    
    if invalid_tickers.empty?
      return true
    else
      return invalid_tickers
    end
         
  end
end