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
	
	
end
