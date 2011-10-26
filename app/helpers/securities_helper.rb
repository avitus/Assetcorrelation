module SecuritiesHelper
  
  # ----------------------------------------------------------------------------------------------------------
  # Get names from tickers
  # Input: ["MSFT", "CSCO"]                 -- an array of upcased ticker symbols
  # Output:["Microsoft Corp", "Cisco Corp"] -- an array of titleized names
  # ----------------------------------------------------------------------------------------------------------   
  def tickers_to_names(tickers)
    
    name_array = Array.new
    
    tickers.each do |t|
      sec = Security.find_by_ticker(t)
      if sec
        name_array << sec.name
      else
        # Request a StandardQuote to get the company names
        quote_type = YahooFinance::StandardQuote
        quote      = YahooFinance::get_quotes( quote_type, t )
        name_array << quote[t.upcase].name.titleize
      end
    end
      
    return name_array
    
  end  
       
end

