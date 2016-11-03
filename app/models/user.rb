class User < ApplicationRecord
  has_many :domains, dependent: :destroy
  has_many :watchers, dependent: :destroy
 
  authenticates_with_sorcery! do |config|
      config.authentications_class = Authentication
  end
  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications
  
  
  validates_confirmation_of :password, message: "should match confirmation", if: :password
  validates_inclusion_of :verified, :in => [true, false]
  validates :username, presence: true
  validates :email, presence: true, uniqueness: true
  before_create :generate_api_auth_token

    
  def self.verified?(email)
    @tmp = User.where("email = ?", email).first
    if (@tmp)
      return @tmp.verified
    else
      return false
    end
  end
  

  private
  def generate_api_auth_token
    loop do
      self.api_auth_token = SecureRandom.base64(64)   # if Devise is NOT present, you can use "SecureRandom.base64(64)" [or some other length] instead
      break unless User.find_by(api_auth_token: api_auth_token)
    end
  end
  
end

