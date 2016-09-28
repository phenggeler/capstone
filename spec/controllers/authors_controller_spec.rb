require 'rails_helper'
require 'spec_helper'

RSpec.describe AuthorsController, type: :controller do
    
   before(:each) do
    @author = Author.create(username: 'john', email: 'test@test.com', password: 'password', password_confirmation: 'password')
    @author.save
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
    
#    describe "PATCH #update" do
#    it "updates the username" do
#      patch :update, :id => @author.id, author: {username: 'two'}
#      @author.reload
#      expect(@author.username).to eq('two')
#    end
#  end
  
#    describe "DELETE #destory" do
#    it "redirects to the index page" do
      #post :create, author: {username: 'john', email: 'test@test.com', password: 'password', password_confirmation: 'password'}
#      @author = Author.last
#      delete :destroy, id: @author.id
#      expect(response).to redirect_to notecards_path
#    end
#  end
    
end