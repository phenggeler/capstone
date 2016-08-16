class UserMailer < ApplicationMailer
    default from: 'siteupdatealerts@gmail.com'


    def welcome_email(author)
        @author = author
        @url  = 'https://project-phenggeler.c9users.io/'
        mail(to: @author.email, subject: 'Welcome to My Awesome Site')
    end

    def site_change_email(watcher, mssg)
        @watcher = watcher
        @mssg = mssg
        puts mssg
        @url  = 'https://project-phenggeler.c9users.io/'
        mail(to: @watcher.email, subject: @watcher.domain + ' has changed')
    end
end
