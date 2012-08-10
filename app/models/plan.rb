class Plan < ActiveRecord::Base
  has_many :subscriptions
  attr_accessible :description, :name, :price
end
