class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!

  def new
    plan = Plan.find(params[:plan_id] || 1)
    @subscription = plan.subscriptions.build
  end

  def create
    @subscription = Subscription.new(params[:subscription])
    if @subscription.save_with_payment
      redirect_to @subscription, :notice => "Thank you for subscribing!"
    else
      render :new
    end
  end

  def show
    @subscription = Subscription.find(params[:id])
  end

end
