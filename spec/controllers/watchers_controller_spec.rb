require 'rails_helper'

RSpec.describe WatchersController, type: :controller do


    
    it "succeeds on index" do
        get :index # experiment
        expect(response).to be_success # verification            
    end
    
describe "Post #create" do
    
    subject { post :create, :watcher => { :domain => "dogville.com", :email => 'test@test.com' }}

    it "responds with 302 status" do
      post :create, watcher: {domain: 'dogville.com', email: 'test@test.com'}
      expect(response.status).to eq(302)            
    end
    
    it "redirects to show after create" do
        expect(subject).to redirect_to :action => :show, :id => assigns(:watcher).id           
    end
    
end

describe "GET #new" do
    it "assigns @watcher" do
      get :new
      expect(@watcher).to eq(@watcher)
    end
end

let (:tmp) {Watcher.create!(domain:'cnn.com', email: 'test@test.com', frequency: 'hours')}

describe "PATCH #update" do
    
    it "updates the name" do
      expect(Watcher.find(tmp.id).id).to eq(tmp.id)
      patch :update, :id => tmp.id, watcher: {domain:'msnbc.com'}
      tmp.reload
      expect(tmp.domain).to eq('msnbc.com')
    end
end
  
describe "DELETE #destory" do
    it "redirects to the index page" do
      #@watcher = Watcher.create(domain: 'one.com', email: 'test@test.com')
      delete :destroy, id: tmp.id
      expect(response).to redirect_to watchers_path
    end
  end
end
