module SecuritiesHelper
  # ----------------------------------------------------------------------------------------------------------
  # Get names from tickers
  # Input: ["MSFT", "CSCO"]                 -- an array of upcased ticker symbols
  # Output:["Microsoft Corp", "Cisco Corp"] -- an array of titleized names
  # ----------------------------------------------------------------------------------------------------------   
  def tickers_to_names(tickers)
    
    # Request a StandardQuote to get the company names
    quote_type = YahooFinance::StandardQuote
    quotes     = YahooFinance::get_quotes( quote_type, tickers )

    # Check that tickers exist

    # create array of names
    name_array = Array.new
    tickers.each { |x| name_array << quotes[x.upcase].name.titleize }
    return name_array
  end     
end
