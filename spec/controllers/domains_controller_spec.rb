require 'rails_helper'


RSpec.describe DomainsController, type: :controller do
    
    before(:all) do
        @user = User.create(username: 'john', email: 'test@test.com', password: 'password', password_confirmation: 'password')
        @user.save
    end
    
describe 'get index' do
    it 'redirects to domain path if logged in' do
        login_user(@user)
        expect(controller.current_user).to be_present
        get :index
        expect(response).to be_success
    end
    
    it 'redirects to new user session path if not logged in' do
        get :index
        expect(response).to redirect_to new_user_session_path
    end
end

describe 'get show' do

    it 'redirects to new_user_session_path if not logged_in' do
        login_user(@user)
        @domain1 = Domain.create(name: 'msnbc.com')
        @domain1.save
        logout_user
        get :show, :id => @domain1.id
        expect(response).to redirect_to new_user_session_path
    end
    
    it 'redirects to show page if logged_in' do
        login_user(@user)
        @domain1 = Domain.create(name: 'nbc.com')
        @domain1.save
        get :show, :id => @domain1.id
        expect(response).to be_success
    end
    
end

    
describe "Post #create" do
    
    before(:each) do
        login_user(@user)
    end
    
    subject { post :create, :domain => { :name => "dogville.com" }}

    it "responds with 302 status" do
      expect(subject.status).to eq(302)            
    end
    
    it "redirects to show after create" do
        expect(subject).to redirect_to :action => :show, :id => assigns(:domain).id           
    end
end


describe "GET #new" do
    it "assigns @domain" do
      get :new
      expect(@domain).to eq(@domain)
    end
end

describe "PATCH #update" do
    
    before(:each) do
        login_user(@user)
    end

    it "updates the name" do
      @domain = Domain.create(name:'pizzahut.com')
      @domain.save
      patch :update, :id => @domain.id, domain: {name: 'two.com'}
      @domain.reload
      expect(@domain.name).to eq('two.com')
    end
  end
  
describe "DELETE #destory" do
    it "redirects to the index page" do
      @domain = Domain.create(name: 'one.com')
      delete :destroy, id: @domain.id, format: 'js'
      expect(response).to have_http_status(:ok)
    end
  end
end
