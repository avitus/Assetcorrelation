class ApplicationController < ActionController::Base
  protect_from_forgery  
  
  # ----------------------------------------------------------------------------------------------------------
  # Admin Authorization
  # ----------------------------------------------------------------------------------------------------------
  helper_method :admin?
  protected
  def admin?
    current_user && current_user.admin?
  end
   
  def authorize
    unless admin?
      flash[:error] = "What you're trying to do requires administrator access."
      redirect_to root_path
      false
    end
  end   
  
  
end

class Array
  
  def mean 
    sum / size
  end
  
  def geometric_mean
    inject(1){ |product, n| product * n } ** (1.0/length)
  end  
  
end  