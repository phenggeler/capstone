class UserMailer < ApplicationMailer
    default from: 'siteupdatealerts@gmail.com'


    def welcome_email(author)
        @author = author
        @url  = 'https://project-phenggeler.c9users.io/'
        mail(to: @author.email, subject: 'Welcome Email')
    end
    
    def new_watcher_email(watcher)
        @watcher = watcher
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
