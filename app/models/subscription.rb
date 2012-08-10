class Subscription < ActiveRecord::Base

  belongs_to :plan
  belongs_to :user

  validates_presence_of :plan_id
  validates_presence_of :user_id

  attr_accessible :plan_id, :stripe_customer_token, :user_id, :stripe_card_token
  attr_accessor :stripe_card_token  # For creating a customer in Stripe
  
  def save_with_payment
    if valid?
      customer = Stripe::Customer.create(description: self.user.email, plan: self.plan.id, card: stripe_card_token)
      self.stripe_customer_token = customer.id
      save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end

end
