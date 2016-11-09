require 'rails_helper'
require 'spec_helper'


RSpec.describe UsersController, type: :controller do

    before(:each) do
        @user = User.create(username: 'john', email: 'unique@test.com', password: 'password', password_confirmation: 'password')
        @user.save
    end
    
    describe 'test zero_users_or_authenticated' do
        it 'will return false' do
            #expect(@controller.zero_users_or_authenticated).to be nil 
        end
    end
    
    describe "Post #create" do
        
        it "redirects after creating user" do
            post :create, user: {username: 'john', email: 'test1@test.com', password: 'password', password_confirmation: 'password'}
            expect(response.status).to eq(302)  
        end
    
        it "sets second user to false" do 
            @user = User.create(username: 'john', email: 'test2@test.com', password: 'password', password_confirmation: 'password')
            @user.save
            @user1 = User.create(username: 'john', email: 'test3@test.com', password: 'password', password_confirmation: 'password', verified: false)
            @user1.save
            expect(@user1.verified).to eq(false)  
        end
        
        it "sets second user to false" do 
            post :create, user: {username: 'john', email: 'test4@test.com', password: 'password', password_confirmation: 'password'}
            @user1 = User.create(username: 'john1', email: 'test5@test.com', password: 'password', password_confirmation: 'password', verified: false)
            @user1.save
            expect(@user1.verified).to eq(false)  
        end
        
        it "sets second user to false" do 
            post :create, user: {username: 'john', email: 'test6@test.com', password: 'password', password_confirmation: 'password'}
            @user.save
            @user1 = User.create(username: 'john1', email: 'test7@test.com', password: 'password', password_confirmation: 'password', verified: false)
            @user1.save
            expect(@user1.verified).to eq(false)  
        end
        
    end
    
    it "succeeds on index" do
        get :index # experiment
        expect(response).to be_success # verification            
    end
    
    describe "GET #new" do
        before(:each) do
            @user = User.create(username: 'john', email: 'test8@test.com', password: 'password', password_confirmation: 'password')
            @user.save
        end
        
        it "assigns @user" do
            get :new
            expect(@user).to eq(@user)
        end
    end
    
    let (:tmp) {User.create!(username: 'john', email: 'test9@test.com', password: 'password', password_confirmation: 'password', verified: false)}

    describe "DELETE #destroy" do
        
        before(:each) do
            @user = User.create(username: 'john', email: 'test10@test.com', password: 'password', password_confirmation: 'password')
        end
        
        it "redirects to index page" do
            tmp
            delete :destroy, id: tmp.id
            expect(response).to redirect_to users_url
        end
    
        it "removes user" do
            expect(User.find(tmp.id).id).to eq(tmp.id)
            delete :destroy, id: tmp.id
            expect{User.find(tmp.id)}.to raise_error ActiveRecord::RecordNotFound
            #expect{delete :destroy, id: tmp.id}.to change{User.count}.by(-1)
        end
    
        it "removes user and count goes down" do
            #expect{delete :destroy, id: tmp.id}.to change{User.count}.by(-1) 
        end
    end
    
    describe "Update #update" do
        before(:each) do
            @user = User.create(username: 'john', email: 'test11@test.com', password: 'password', password_confirmation: 'password')
            @user.save
        end
        
        it "updates user" do 
        #     expect{put :update, name: "george"}.to change{User.name}.to('george') 
        end
    
        it 'updates user with put' do
            expect(User.find(tmp.id).id).to eq(tmp.id)
            put :update, :id => tmp.id, user: {id: tmp.id, username: 'jackson'}
            tmp.reload
            expect(tmp.username).to eq('jackson')
        end 
        
        it 'updates user verified status' do
            expect(User.find(tmp.id).id).to eq(tmp.id)
            put :update, :id => tmp.id, user: {id: tmp.id, verified: true}
            tmp.reload
            expect(tmp.verified).to eq(true)
        end 
    end
end