class UserMailer < ApplicationMailer
    default from: 'me@sandbox81cd4c03d386416687445763e2cfeffe.mailgun.org'


    def welcome_email(user)
        @user = user
        mail(to: @user.email, subject: 'Welcome Email')
    end
    
    def new_user_email(signup)
        @signup = signup
        mail(to: 'peter.john.henggeler@gmail.com', subject: @signup.username + " has requested access to site")
    end
    
    def approval_user_email(user)
        @user = user
        mail(to: @user.email, subject: 'Your Account Has Been Approved')
    end
    
    def suspended_user_email(user)
       @user = user
        mail(to: @user.email, subject: 'Your Account Has Been Suspended')
    end
    
    def new_watcher_email(watcher, content)
        @watcher = watcher
        @content = content
        @url  = 'https://project-phenggeler.c9users.io/'
        mail(to: @watcher.email, subject: 'You have set up a watcher alert for '+@watcher.domain)
    end

    def site_change_email(watcher, mssg)
        @watcher = watcher
        @mssg = mssg
        @url  = 'https://project-phenggeler.c9users.io/'
        mail(to: @watcher.email, subject: @watcher.domain + ' has changed')
    end
    
    
end
