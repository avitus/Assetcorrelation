class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
  	
    @tab = "account" 
    @sub = "profile"   	
  	
    @user = current_user

  end

end
