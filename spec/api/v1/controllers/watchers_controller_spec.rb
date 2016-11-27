require 'rails_helper'

RSpec.describe Api::V1::WatchersController, type: :controller do
  let(:watcher) { Watcher.create(watcher: 'lendingclub.com', email: 'peter.john.henggeler@gmail.com', frequency: 'minutres')}

  let (:user) {User.create(username: 'john', email: 'test@test.com', password: 'password', password_confirmation: 'password', api_auth_token: SecureRandom.base64(64), verified: true)}


  context "unauthenticated user" do
    it "can't get index" do
      get :index
      expect(response).to have_http_status(401)
    end
  end

  context "authorized user" do
    before :each do
      controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(user.api_auth_token)
     # controller.authenticate_user!
    end

    describe "GET index" do
      it "succeeds" do
        get :index
        expect(response).to have_http_status(:ok)
      end

      it "responds with JSON" do
        get :index
        expect(response.content_type).to eq 'application/json'
      end

      it "succeeds" do
        watcher
        login_user(@user)
        expect(controller.current_user).to be_present
        get :index
        expect(response).to have_http_status(:ok)
      end
    end
  end

end