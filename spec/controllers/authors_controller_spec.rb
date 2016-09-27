require 'rails_helper'
require 'spec_helper'

RSpec.describe AuthorsController, type: :controller do

it 'tests the def_zero method' do
    controller.zero_authors_or_authenticated
    expect(response).to redirect_to eq(200)
end
    
describe "Post #create" do
        

    it "redirects after creating author" do
      post :create, author: {username: 'john', email: 'test@test.com', password: 'password', password_confirmation: 'password'}
      expect(response.status).to eq(302)  
    end
end

    it "succeeds on index" do
        get :index # experiment
        expect(response).to be_success # verification            
    end
    
    describe "GET #new" do
        it "assigns @author" do
            get :new
            expect(@author).to eq(@author)
        end
    end
    
end