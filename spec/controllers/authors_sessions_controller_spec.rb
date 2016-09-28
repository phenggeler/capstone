require 'rails_helper'
require 'spec_helper'

RSpec.describe AuthorSessionsController, type: :controller do

  before(:each) do
    @author = Author.create(username: 'john', email: 'test@test.com', password: 'password', password_confirmation: 'password')
    @author.save
  end
    
  describe "POST #create" do
      it 'can create new author session' do
      post :create, author_session: {email: @author.email, password: 'password'}
      expect(response.status).to eq(200)
    end
  end
end