require 'rails_helper'
require "spec_helper"

RSpec.describe User, type: :model do

let(:user) {User.create(username:'kyle', email:'peter.john.henggeler@gmail.com', password: 'password', password_confirmation:'password', verified: false)}
#let(:categorywords) {['one', 'two words', 'three']}

  it "has a username" do
     expect(User.create(username:'kyle', email:'peter.john.henggeler@gmail.com', password: 'password', password_confirmation:'password', verified: false)).to be_valid
  end
  it "is invalid without a username" do
      expect(User.create(email:'peter.john.henggeler@gmail.com', password: 'password', password_confirmation:'password', verified: false)).not_to be_valid
  end
  it "is invalid without an email" do
      expect(User.create(username:'kyle', password: 'password', password_confirmation:'password', verified: false)).not_to be_valid
  end
     
  it "sets verify to false" do
    @user = User.create(username: 'kyle',email:'peter.john.henggeler@gmail.com', password: 'password', password_confirmation:'password', verified: false)
    expect(@user.verified).to eq(false)
  end
  
  it 'has a working verified? method' do
    expect(User.verified?(user.email)).to eq(false)
  end
  
  
  
end