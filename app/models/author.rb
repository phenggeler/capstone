class Author < ApplicationRecord
  has_many :domains, dependent: :destroy
  has_many :watchers, dependent: :destroy
  authenticates_with_sorcery!
    validates_confirmation_of :password, message: "should match confirmation", if: :password
    validates_inclusion_of :verified, :in => [true, false]
    validates :username, presence: true
    validates :email, presence: true, uniqueness: true
    
    def self.verified?(email)
      @tmp = Author.where("email = ?", email).first
      if (@tmp)
        return @tmp.verified
      else
        return -1
      end
    end
  end

