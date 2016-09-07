require 'rails_helper'
require "spec_helper"

RSpec.describe Author, type: :model do

let(:author) {Author.create(username:'kyle', email:'peter.john.henggeler@gmail.com', password: 'password', password_confirmation:'password', verified: false)}
#let(:categorywords) {['one', 'two words', 'three']}

  it "has a username" do
     Author.create(username:'kyle', email:'peter.john.henggeler@gmail.com', password: 'password', password_confirmation:'password', verified: false).should be_valid
  end
  it "is invalid without a username" do
      Author.create(email:'peter.john.henggeler@gmail.com', password: 'password', password_confirmation:'password', verified: false).should_not be_valid
  end
  it "is invalid without a lastname" do
      Author.create(username:'kyle', password: 'password', password_confirmation:'password', verified: false).should_not be_valid
  end
  
end