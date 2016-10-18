require 'rails_helper'
require 'spec_helper'

RSpec.describe AuthorsController, type: :controller do

    before(:each) do
        @author = Author.create(username: 'john', email: 'test@test.com', password: 'password', password_confirmation: 'password')
        @author.save
    end
    
    describe 'test zero_authors_or_authenticated' do
        it 'will return false' do
            expect(@controller.zero_authors_or_authenticated).to be nil 
        end
    end
    
    describe "Post #create" do
        
        it "redirects after creating author" do
            post :create, author: {username: 'john', email: 'test@test.com', password: 'password', password_confirmation: 'password'}
            expect(response.status).to eq(302)  
        end
    
        it "sets second author to false" do 
            @author = Author.create(username: 'john', email: 'test@test.com', password: 'password', password_confirmation: 'password')
            @author.save
            @author1 = Author.create(username: 'john', email: 'test@test.com', password: 'password', password_confirmation: 'password', verified: false)
            @author1.save
            expect(@author1.verified).to eq(false)  
        end
        
        it "sets second author to false" do 
            post :create, author: {username: 'john', email: 'test@test.com', password: 'password', password_confirmation: 'password'}
            @author1 = Author.create(username: 'john1', email: 'test@test.com', password: 'password', password_confirmation: 'password', verified: false)
            @author1.save
            expect(@author1.verified).to eq(false)  
        end
        
        it "sets second author to false" do 
            post :create, author: {username: 'john', email: 'test@test.com', password: 'password', password_confirmation: 'password'}
            @author.save
            @author1 = Author.create(username: 'john1', email: 'test@test.com', password: 'password', password_confirmation: 'password', verified: false)
            @author1.save
            expect(@author1.verified).to eq(false)  
        end
        
    end
    
    it "succeeds on index" do
        get :index # experiment
        expect(response).to be_success # verification            
    end
    
    describe "GET #new" do
        before(:each) do
            @author = Author.create(username: 'john', email: 'test@test.com', password: 'password', password_confirmation: 'password')
            @author.save
        end
        
        it "assigns @author" do
            get :new
            expect(@author).to eq(@author)
        end
    end
    
    let (:tmp) {Author.create!(username: 'john', email: 'test@test.com', password: 'password', password_confirmation: 'password', verified: false)}

    describe "DELETE #destroy" do
        
        before(:each) do
            @author = Author.create(username: 'john', email: 'test@test.com', password: 'password', password_confirmation: 'password')
            @author.save
        end
        
        it "redirects to index page" do
            tmp
            delete :destroy, id: tmp.id
            expect(response).to redirect_to authors_url
        end
    
        it "removes author" do
            expect(Author.find(tmp.id).id).to eq(tmp.id)
            delete :destroy, id: tmp.id
            expect{Author.find(tmp.id)}.to raise_error ActiveRecord::RecordNotFound
            #expect{delete :destroy, id: tmp.id}.to change{Author.count}.by(-1)
        end
    
        it "removes author and count goes down" do
            #expect{delete :destroy, id: tmp.id}.to change{Author.count}.by(-1) 
        end
    end
    
    describe "Update #update" do
        before(:each) do
            @author = Author.create(username: 'john', email: 'test@test.com', password: 'password', password_confirmation: 'password')
            @author.save
        end
        
        it "updates author" do 
        #     expect{put :update, name: "george"}.to change{Author.name}.to('george') 
        end
    
        it 'updates author with put' do
            expect(Author.find(tmp.id).id).to eq(tmp.id)
            put :update, :id => tmp.id, author: {id: tmp.id, username: 'jackson'}
            tmp.reload
            expect(tmp.username).to eq('jackson')
        end 
        
        it 'updates author verified status' do
            expect(Author.find(tmp.id).id).to eq(tmp.id)
            put :update, :id => tmp.id, author: {id: tmp.id, verified: true}
            tmp.reload
            expect(tmp.verified).to eq(true)
        end 
    end
end