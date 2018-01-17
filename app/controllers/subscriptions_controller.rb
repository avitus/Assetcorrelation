class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def new
    plan = Plan.find(params[:plan_id] || 1)
    @subscription = plan.subscriptions.build
  end

  def create
    @subscription = Subscription.new(subscription_params)
    if @subscription.save_with_payment
      redirect_to @subscription, :notice => "Thank you for subscribing!"
    else
      render :new
    end
  end

  def show
    @subscription = Subscription.find(params[:id])
  end

  private

  def subscription_params
    params.requrie(:subscription).permit(:plan_id, :stripe_customer_token, :user_id, :stripe_card_token)
  end

end
