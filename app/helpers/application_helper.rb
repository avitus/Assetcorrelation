# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  # ----------------------------------------------------------------------------------------------------------
  # Convert days to meaningful english (intervals should match those in 'quantalign' above
  # ----------------------------------------------------------------------------------------------------------  
  def days_to_words(days)
    period_in_words = case days
      when   27..32   then 'month'
      when   87..92   then 'three months'
      when  179..184  then 'six months'
      when  361..367  then 'year'            # should be 361 on lower bound
      when  544..549  then 'year and a half'
      when  728..732  then 'two years'
      when 1822..1827 then 'five years'
      when 3649..3653 then 'ten years'
      when 7301..7307 then 'two decades'     # add a bit of extra buffer to make sure nothing gets out
      else days.to_s + ' days'
    end
    return period_in_words
  end
  
  # ----------------------------------------------------------------------------------------------------------
  # Color correlation matrix cells to indicate degree of correlation
  # ----------------------------------------------------------------------------------------------------------  
  def css_correlation( correlation, include_class_text = true )
    value = 'moderate'
    value = 'mild-neg'  if correlation <  0.00
    value = 'negative'  if correlation < -0.50
    value = 'strongpos' if correlation >  0.75
    
    if include_class_text
      'class="' << value << '"'
    else
      value
    end
  end

  # ----------------------------------------------------------------------------------------------------------
  # Returns a stock quote for a single stock ticker
  # Input: 'CSCO'
  # ---------------------------------------------------------------------------------------------------------- 
  def stock_quote(ticker)
    YahooFinance::get_quotes( YahooFinance::StandardQuote, ticker )[ticker].lastTrade
  end
  
end
