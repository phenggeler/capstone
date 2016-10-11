class UserMailer < ApplicationMailer
    default from: 'siteupdatealerts@gmail.com'


    def welcome_email(author)
        @author = author
        @url  = 'https://project-phenggeler.c9users.io/'
        mail(to: @author.email, subject: 'Welcome Email')
    end
    
    def new_user_email(signup)
        @signup = signup
        mail(to: 'peter.john.henggeler@gmail.com', subject: @signup.username + " has requested access to site")
    end
    
    def approval_user_email(author)
        @author = author
        mail(to: @author.email, subject: 'Your Account Has Been Approved')
    end
    
    def suspended_user_email(author)
       @author = author
        mail(to: @author.email, subject: 'Your Account Has Been Suspended')
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
        puts mssg
        @url  = 'https://project-phenggeler.c9users.io/'
        mail(to: @watcher.email, subject: @watcher.domain + ' has changed')
    end
    
    
end
