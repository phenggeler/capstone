class Authentication < ApplicationRecord
  
  #attr_accessor :user_id, :provider, :uid
  belongs_to :user
  
end
