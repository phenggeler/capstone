desc "This task is called by the Heroku scheduler add-on"
require 'net/http'
require 'rake'

namespace :scheduler do
  desc "Ping our heroku dyno every 10, 60 or 3600 min"
  task :start => :environment do
    puts "Making the attempt to send email"
    watchers = Watcher.all
    watchers.each do |watcher|
      if (watcher.worthScanning?(watcher))
        puts "sending email for " + watcher.domain
        watcher.current?(watcher)
      end
    end
  end
end