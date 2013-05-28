class User < ActiveRecord::Base  
  has_many :messages
  has_many :incomings
  has_many :responses
end
