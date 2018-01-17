class Position < ActiveRecord::Base

  belongs_to :security
  
  accepts_nested_attributes_for :security

end
