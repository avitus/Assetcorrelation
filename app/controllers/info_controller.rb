class InfoController < ApplicationController
  def primer
    @tab = "learn" 
    @sub = "primer"  	
  end
  
  def support
    @tab = "support" 
    @sub = "faq"  	
  end
end