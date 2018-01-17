class PlansController < ApplicationController
  def index
    @plans = Plan.order("price")
  end

  private

  def plan_params
    params.requrie(:plan).permit(:description, :name, :price)
  end

end
