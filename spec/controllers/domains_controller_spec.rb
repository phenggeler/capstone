require 'rails_helper'

RSpec.describe DomainsController, type: :controller do
    
    before(:all) do
        @author = Author.create(username: 'john', email: 'test@test.com', password: 'password', password_confirmation: 'password')
        @author.save
    end
    
describe 'get index' do
    it 'redirects to domain path if logged in' do
        login_user(@author)
        expect(controller.current_user).to be_present
        get :index
        expect(response).to be_success
    end
    
    it 'redirects to new author session path if not logged in' do
        get :index
        expect(response).to redirect_to new_author_session_path
    end
end

describe 'get show' do

    it 'redirects to new_author_session_path if not logged_in' do
        login_user(@author)
        @domain1 = Domain.create(name: 'msnbc.com')
        @domain1.save
        logout_user
        get :show, :id => @domain1.id
        expect(response).to redirect_to new_author_session_path
    end
    
    it 'redirects to show page if logged_in' do
        login_user(@author)
        @domain1 = Domain.create(name: 'nbc.com')
        @domain1.save
        get :show, :id => @domain1.id
        expect(response).to be_success
    end
    
end

    
describe "Post #create" do
    
    before(:each) do
        login_user(@author)
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
        login_user(@author)
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
      delete :destroy, id: @domain.id
      expect(response).to redirect_to domains_path
    end
  end
end
