require 'rails_helper'
require 'spec_helper'

RSpec.describe UserSessionsController, type: :controller do

  before(:each) do
    @user = User.create(username: 'john', email: 'test@test.com', password: 'password', password_confirmation: 'password', verified: true)
    @user.save
    
    @user1 = User.create(username: 'john1', email: 'test2@test.com', password: 'password', password_confirmation: 'password', verified: false)
    @user1.save
  end
    
  describe "POST #create" do
    it 'fails to create user session when user is not verified' do
      post :create, user_session: {email: @user.email, password: 'password'}
      expect(response.status).to be 302
    end
    
    it 'has alert page present when user is not verified' do 
      post :create, user_session: {email: @user.email, password: 'password'}
      expect(expect(flash[:alert]).to be_present)
    end
    
    it 'has alert page present when user is verified' do 
      login_user(@user1)
      expect(response.status).to be 200
    end
    
    it "should get destroy" do
      login_user(@user1)
      get :destroy
      expect(response).to redirect_to new_user_session_path
    end
    
    it "should get create" do
      @tmp = User.create(username: 'john3', email: 'test3@test.com', password: 'password', password_confirmation: 'password', verified: true)
      post :create, user_session: {email: @tmp.email, password: 'password'}
      login_user(@tmp)
      expect(logged_in?).to eq true
    end
  end
end