  require 'rails_helper'

  RSpec.describe Api::V1::BaseController, type: :controller do
     let(:user) {User.create(username: 'john', email: 'test@test.com', password: 'password', password_confirmation: 'password', api_auth_token: SecureRandom.base64(64), verified: true)}

    context "authorized" do
      before :each do
        controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(user.api_auth_token)
        controller.authenticate_user!
      end

      describe "#authenticate_user!" do
        skip 'finds user by their token' do
          expect(assigns(:current_user)).to eq user
        end
      end
      
      describe "#authorize_user" do
        skip 'finds user by their token' do
          authorize_user
          expect(response).to be(403)
        end
      end
      
    end
  end