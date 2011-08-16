module ApplicationHelper
	
  def page_title(title = nil)
    if title
      content_for(:page_title) { title + " - AssetCorrelation" }
    else
      content_for?(:page_title) ? content_for(:page_title) : "AssetCorrelation"
    end
  end
 
  def page_description(description = nil)
    if description
      content_for(:page_description) { description }
    else
      content_for?(:page_description) ? content_for(:page_description) : t(:default, :scope => 'page_descriptions')
    end
  end

  # ----------------------------------------------------------------------------------------------------------
  # Outputs the corresponding flash message if any are set
  # ----------------------------------------------------------------------------------------------------------       
  def flash_messages
    messages = ''.html_safe
    [:error, :notice].each do |t|
      if flash[t]
        messages << content_tag(:div, flash[t].html_safe, :id => "flash-#{t}", :class => "flash gray-box-bg" ) << '<div><img src="/images/trans.png" width="1" height="10" alt="" /></div>'.html_safe
      end
    end
    unless messages.blank?
       content_tag(:div, messages)
    end
  end    

  # ----------------------------------------------------------------------------------------------------------
  # Adds 'selected' class to menu item matching current page
  # ---------------------------------------------------------------------------------------------------------- 
  def tab( tab, include_class_text = true )

    value = 'inactive'
    value = 'selected' if tab
    
    if include_class_text
      ('class="' << value << '"').html_safe
    else
      value
    end
  end  

  # ----------------------------------------------------------------------------------------------------------
  # Adds 'selected' class to menu item matching current page
  # ---------------------------------------------------------------------------------------------------------- 
  def sub( sub, include_class_text = true )

    value = 'inactive'
    value = 'active' if sub
    
    if include_class_text
      ('class="' << value << '"').html_safe
    else
      value
    end
  end  	
	
  # ----------------------------------------------------------------------------------------------------------
  # Color correlation matrix cells to indicate degree of correlation
  # ----------------------------------------------------------------------------------------------------------
  def css_correlation( correlation, include_class_text = true )
    value = 'moderate'
    value = 'mild-neg' if correlation < 0.10
    value = 'negative' if correlation < -0.50
    value = 'strongpos' if correlation > 0.75
    
    if include_class_text
      'class=' << value
    else
      value
    end
  end
  
  # ----------------------------------------------------------------------------------------------------------
  # Is value within range
  # ----------------------------------------------------------------------------------------------------------
  def in_range( x, range, include_class_text = true )
  	
  	a, b = range.split(' - ')
  	a = a.to_i
  	b = b.to_i
  	
    if x >= a and x <= b
    	value = 'in_range'
    else
    	value = 'out_of_range'
    end
    
    if include_class_text
      'class=' << value
    else
      value
    end
  end  
  
  
  # ----------------------------------------------------------------------------------------------------------
  # Convert days to meaningful english (intervals should match those in 'quantalign' above
  # ----------------------------------------------------------------------------------------------------------
  def days_to_words(days)
    period_in_words = case days
      when 27..32 then 'month'
      when 87..92 then 'three months'
      when 179..184 then 'six months'
      when 361..367 then 'year' # should be 361 on lower bound
      when 544..549 then 'year and a half'
      when 728..732 then 'two years'
      when 1822..1827 then 'five years'
      when 3649..3653 then 'ten years'
      when 7301..7307 then 'two decades' # add a bit of extra buffer to make sure nothing gets out
      else days.to_s + ' days'
    end
    return period_in_words
  end  
  
  
  	
end
