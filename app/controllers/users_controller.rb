class UsersController < ApplicationController
  
  before_action :authenticate_user!

  # ----------------------------------------------------------------------------------------------------------
  # Show user
  # ---------------------------------------------------------------------------------------------------------- 
  def show	
    @tab = "account" 
    @sub = "profile"   	
  	
    @user = current_user
  end

  # ----------------------------------------------------------------------------------------------------------
  # Get CSDL string 
  # ---------------------------------------------------------------------------------------------------------- 
  def custom_csdl
   
    csdl_string = current_user.custom_news_csdl

    respond_to do |format|
      format.json { render :json => { :csdl => csdl_string } }
    end 
       
  end

  private

  def user_params
    params.requrie(:user).permit(:name, :email, :password, :password_confirmation, :remember_me, :admin)
  end

end
