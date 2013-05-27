class User < ActiveRecord::Base  
  has_many :incomings
  has_many :outgoings
end
