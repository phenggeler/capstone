require 'rails_helper'
require 'spec_helper'

RSpec.describe AuthorsController, type: :controller do

  describe "Post #destroy" do

    it "deletes the user" do
        @tmp = Author.create(username:'kyle', email:'peter.john.henggeler@gmail.com', password: 'password', password_confirmation:'password')
        num = Author.all.count
        @tmp.destroy
        x = Author.all.count
        expect(num = x+1)
    end
  end
    
  describe "POST #create" do
    it "increases number of authors by 1" do
        num = Author.all.count
        Author.create(username:'kyle', email:'peter.john.henggeler@gmail.com', password: 'password', password_confirmation:'password')
        tmp = Author.all.count
        #post :create, item: {email: 'peter.john.henggeler@gmail.com', password: 'password'}
        expect(tmp = (num+1))
    end
    
    it "fails when not specifying username" do
        num = Author.all.count
        Author.create(email:'peter.john.henggeler@gmail.com', password: 'password', password_confirmation:'password')
        tmp = Author.all.count
        #post :create, item: {email: 'peter.john.henggeler@gmail.com', password: 'password'}
        expect(tmp == num)
    end
    
    it "fails when not specifying email" do
        num = Author.all.count
        Author.create(username:'peter.john.henggeler@gmail.com', password: 'password', password_confirmation:'password')
        tmp = Author.all.count
        #post :create, item: {email: 'peter.john.henggeler@gmail.com', password: 'password'}
        expect(tmp == num)
    end
    
    it "cannot add duplicate email addresses" do
        Author.create(username: 'kyle',email:'peter.john.henggeler@gmail.com', password: 'password', password_confirmation:'password')
        num = Author.all.count
        Author.create(username: 'kyle',email:'peter.john.henggeler@gmail.com', password: 'password', password_confirmation:'password')
        tmp = Author.all.count
        #post :create, item: {email: 'peter.john.henggeler@gmail.com', password: 'password'}
        expect(tmp == num)
    end
    
    it "cannot add without massing password" do
        num = Author.all.count
        Author.create(username: 'kyle',email:'peter.john.henggeler@gmail.com', password: 'password', password_confirmation:'password1')
        tmp = Author.all.count
        #post :create, item: {email: 'peter.john.henggeler@gmail.com', password: 'password'}
        expect(tmp == num)
    end
    
    it "can add duplicate usernames" do
        Author.create(username: 'kyle',email:'peter.john.henggeler@gmail.com', password: 'password', password_confirmation:'password')
        num = Author.all.count
        Author.create(username: 'kyle',email:'1peter.john.henggeler@gmail.com', password: 'password', password_confirmation:'password')
        tmp = Author.all.count
        #post :create, item: {email: 'peter.john.henggeler@gmail.com', password: 'password'}
        expect(tmp == num+1)
    end
    
    it "sets verify to false" do
        @author = Author.create(username: 'kyle',email:'peter.john.henggeler@gmail.com', password: 'password', password_confirmation:'password')
        expect(@author.verified == false)
    end
    
    it "redirects to author show page" do
        #@author = Author.create(username: 'kyle',email:'peter.john.henggeler@gmail.com', password: 'password', password_confirmation:'password')
        post :create, author: {username: 'kyle',email:'peter.john.henggeler@gmail.com', password: 'password', password_confirmation:'password'}
        expect(response).to redirect_to author_path(Author.last.id)
    end
    
    let(:author) {Author.create(username:'kyle', email:'peter.john.henggeler@gmail.com', password: 'password', password_confirmation:'password', verified: false)}
    let(:mail) {UserMailer.welcome_email(author).deliver_now }

   it 'renders the receiver email' do
        #@author = Author.create(username: 'kyle',email:'peter.john.henggeler@gmail.com', password: 'password', password_confirmation:'password')
        expect(mail.to).to eq([author.email])
    end
  
  it 'renders the subject' do
        #@author = Author.create(username: 'kyle',email:'peter.john.henggeler@gmail.com', password: 'password', password_confirmation:'password')
        expect(mail.subject).to eq('Welcome Email')
    end

    it 'renders the sender email' do
        #@author = Author.create(username: 'kyle',email:'peter.john.henggeler@gmail.com', password: 'password', password_confirmation:'password')
        expect(mail.from).eql?('siteupdatealerts@gmail.com')
    end

    let(:mail2) {UserMailer.new_user_email(author).deliver_now }
    
 
    it 'renders the subject' do
        #@author = Author.create(username: 'kyle',email:'peter.john.henggeler@gmail.com', password: 'password', password_confirmation:'password')
        expect(mail2.subject).to eq(author.username + " has requested access to site")
    end

end
end