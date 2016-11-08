require 'rails_helper'
require 'spec_helper'

describe OauthsController do
    
  describe "#callback" do
    let (:tmp) {User.create!(username: 'john', email: 'test9@test.com', password: 'password', password_confirmation: 'password', verified: false)}
    
    it 'logs in a linked user' do
      OauthsController.any_instance.should_receive(:login_from).with('google').and_return(Authentication.new)
      session[:user_id] = tmp.id
      get :callback, provider: 'google', code: '123'

      expect(flash[:notice]).to be_present
    end

    it 'displays an error if user is not logged in and their google account is not linked' do
      OauthsController.any_instance.should_receive(:login_from).and_return(false)

      get :callback, provider: 'google', code: '123'
      expect(flash[:alert]).to be_present
    end
    
    it 'logins at provider' do
      get :oauth, provider: 'google'
    end
  end


end
