class HomeController < ApplicationController
  def index
    # @users = User.all
    @news  = Topsy.search("asset correlation", :perpage => 3, :page => 1, :window => 'm')
  end
end
