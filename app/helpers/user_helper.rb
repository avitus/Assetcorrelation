module UserHelper
  
  # Determines the CSS class based on either the count given
  # (returns 'even' or 'odd' as the CSS class name) or the class
  # given (returns the string version of the class, lowercased,
  # as the CSS class name)
  def css_return( ret_multiple, include_class_text = true )
    value = 'return-ok'
    value = 'return-neg' if ret_multiple<1
    value = 'return-great' if ret_multiple>3
    
    if include_class_text
      'class="' << value << '"'
    else
      value
    end
  end

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
  
  # Coloring for stock quotes page
  def quote_color( change, include_class_text = true )
    value = 'down'
    value = 'unchanged' if change ==  0.00
    value = 'up'        if change >   0.00
    value = 'cashmoney' if change >   2.50
    
    if include_class_text
      'class="' << value << '"'
    else
      value
    end
  end  
end
