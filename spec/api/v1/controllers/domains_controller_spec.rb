 require 'rails_helper'

  RSpec.describe Api::V1::DomainsController, type: :controller do
    let(:user) {User.create(username: 'john', email: 'test@test.com', password: 'password', password_confirmation: 'password', api_auth_token: SecureRandom.base64(64), verified: true)}
    let(:domain) { Domain.create(name: 'lendingclub.com')}

    context "unauthenticated user" do
      it "can't get index" do
        get :index
        expect(response).to have_http_status(401)
      end
    end

    context "authorized user" do
      before :each do
        controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(user.api_auth_token)
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
          domain
          login_user(@user)
          expect(controller.current_user).to be_present
          get :index
          expect(response).to be_success
        end
      end
    end

  end