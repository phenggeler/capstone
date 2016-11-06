require 'rails_helper'
require 'spec_helper'

describe OauthsController do
    
  describe "#callback" do
    it 'logs in a linked user' do
      OauthsController.any_instance.should_receive(:login_from).with('google').and_return(Authentication.new)
      alice = Fabricate(:user)
      session[:user_id] = alice.id
      get :callback, provider: 'google', code: '123'

      expect(flash[:notice]).to be_present
    end

    it 'displays an error if user is not logged in and their google account is not linked' do
      OauthsController.any_instance.should_receive(:login_from).and_return(false)

      get :callback, provider: 'google', code: '123'
      expect(flash[:alert]).to be_present
    end
  end


end
