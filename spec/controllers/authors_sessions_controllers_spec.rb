require 'rails_helper'
require 'spec_helper'

RSpec.describe AuthorSessionsController, type: :controller do

    
    
  describe "POST #create" do
    it "increases number of authors by 1" do
        num = Author.all.count
        Author.create(username:'kyle', email:'peter.john.henggeler@gmail.com', password: 'password', password_confirmation:'password')
        tmp = Author.all.count
        #post :create, item: {email: 'peter.john.henggeler@gmail.com', password: 'password'}
        expect(tmp = (num+1))
    end
end
end