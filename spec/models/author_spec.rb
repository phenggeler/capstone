require 'rails_helper'
require "spec_helper"

RSpec.describe Author, type: :model do

let(:author) {Author.create(username:'kyle', email:'peter.john.henggeler@gmail.com', password: 'password', password_confirmation:'password', verified: false)}
#let(:categorywords) {['one', 'two words', 'three']}

  it "has a username" do
     expect(Author.create(username:'kyle', email:'peter.john.henggeler@gmail.com', password: 'password', password_confirmation:'password', verified: false)).to be_valid
  end
  it "is invalid without a username" do
      expect(Author.create(email:'peter.john.henggeler@gmail.com', password: 'password', password_confirmation:'password', verified: false)).not_to be_valid
  end
  it "is invalid without an email" do
      expect(Author.create(username:'kyle', password: 'password', password_confirmation:'password', verified: false)).not_to be_valid
  end
     
  it "sets verify to false" do
    @author = Author.create(username: 'kyle',email:'peter.john.henggeler@gmail.com', password: 'password', password_confirmation:'password', verified: false)
    expect(@author.verified).to eq(false)
  end
  
  it 'has a working verified? method' do
    expect(Author.verified?(author.email)).to eq(false)
  end
  
end