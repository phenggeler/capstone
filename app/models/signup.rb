class Signup < ApplicationRecord
    validates :username, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true
    validates :password_confirmation, presence: true
end
