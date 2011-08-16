class ApplicationController < ActionController::Base
  protect_from_forgery  
end

class Array
  
  def mean 
    sum / size
  end
  
  def geometric_mean
    inject(1){ |product, n| product * n } ** (1.0/length)
  end  
  
end  