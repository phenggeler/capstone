require 'rails_helper'
require 'spec_helper'

RSpec.describe AuthorSessionsController, type: :controller do

  before(:each) do
    @author = Author.create(username: 'john', email: 'test@test.com', password: 'password', password_confirmation: 'password')
    @author.save
    
    @author1 = Author.create(username: 'john1', email: 'test2@test.com', password: 'password', password_confirmation: 'password', verified: false)
    @author1.save
  end
    
  describe "POST #create" do
    it 'fails to create author session when user is not verified' do
      post :create, author_session: {email: @author.email, password: 'password'}
      expect(response.status).to be 200
    end
    
    it 'has alert page present when user is not verified' do 
      post :create, author_session: {email: @author.email, password: 'password'}
      expect(expect(flash[:alert]).to be_present)
    end
    
    it 'has alert page present when user is verified' do 
      login_user(@author1)
      expect(response.status).to be 200
    end
    
    it "should get destroy" do
      login_user(@author1)
      get :destroy
      expect(response).to redirect_to new_author_session_path
    end
    
    it "should get create" do
      @tmp = Author.create(username: 'john3', email: 'test3@test.com', password: 'password', password_confirmation: 'password', verified: true)
      post :create, author_session: {email: @tmp.email, password: 'password'}
      login_user(@tmp)
      expect(logged_in?).to eq true
    end
  end
end