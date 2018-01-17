class Portfolio < ActiveRecord::Base

  has_many	  :positions, :dependent => :destroy
  has_many    :securities, :through => :positions
  belongs_to  :user

  accepts_nested_attributes_for :positions, :reject_if => lambda { |a| a[:security_id].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :securities
  
end
